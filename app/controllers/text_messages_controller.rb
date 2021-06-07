class TextMessagesController < ApplicationController
  include ActionView::Layouts
  include ActionController::Rendering
  include ActionController::MimeResponds

  def index
    @text_messages = TextMessage.all.order(created_at: :desc)

    render :index
  end

  # http://localhost:3000/text_messages/new
  def new
    @sms = TextMessage.new

    render :new
  end

  def create
    @sms = TextMessage.create!(text_message_params)
    sms_service = SmsService.new(@sms.id).transmit!

    respond_to do |format|
      if @sms.reload.provider_message_id
        format.json { render plain: { sms: @sms, success: true }.to_json, status: 200, content_type: 'application/json' }
      else
        format.json { render plain: { sms: @sms, success: false }.to_json, content_type: 'application/json' }
      end
    end
  end

  # POST /text_messages/delivery_status(.:format)
  def delivery_status
    @sms = TextMessage.find_by!(provider_message_id: provider_params[:message_id])
    @sms.update!(provider_status: provider_params[:status])
  end

  private

  def text_message_params
    params.require(:text_message).permit(
      :from_number,
      :to_number,
      :message
    )
  end

  def provider_params
    params.permit(
      :message_id,
      :status,
      :format,
      text_message: {}
    )
  end
end
