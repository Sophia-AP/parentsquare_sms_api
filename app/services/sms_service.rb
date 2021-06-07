require 'net/http'

class SmsService

  attr_accessor :errors

  def initialize(id)
    @sms = TextMessage.find(id)
    @sms.provider_id = select_provider

    @request_body = {
      to_number: @sms.to_number,
      message: @sms.message,
      callback_url: @sms.callback_url
    }.to_json
  end

  #
  # Messages should be weighted so that:
  #   provider 1 receives 30% of requests
  #   provider 2 receives 70% of requests
  #
  def select_provider
    case rand(100) + 1
      when  1..30
        1
      else
        2
    end
  end

  def transmit!
    begin
      send_to_provider
    rescue
      alternate_provider!
      send_to_provider
    ensure
      @sms.save!
    end
  end

  private

    def send_to_provider
      uri = URI(TextMessage::PROVIDERS[@sms.provider_id])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
      request.body = @request_body

      handle_response(http.request(request))
    end

    def handle_response(resp)
      case resp.code
        when '200'
          body = JSON.parse(resp.body)
          @sms.assign_attributes(provider_message_id: body['message_id'])
        when '500'
          @sms.assign_attributes(provider_status: 'failed')

          raise StandardError.new('ERROR: Provider is offline.')
        else
          @sms.assign_attributes(provider_status: 'failed')

          raise StandardError.new("ERROR #{resp.code}: Something went wrong!")
      end
    end

    # TODO: We need to optimize this if we ever have more than two providers.
    def alternate_provider!
      @sms.provider_id = TextMessage::PROVIDERS.except(@sms.provider_id).keys.first
    end
end
