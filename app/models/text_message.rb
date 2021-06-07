# == Schema Information
#
# Table name: text_messages
#
#  id                  :integer          not null, primary key
#  callback_url        :string
#  from_number         :string
#  message             :text             not null
#  provider_status     :string
#  to_number           :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  provider_id         :integer
#  provider_message_id :string
#

class TextMessage < ApplicationRecord
  CALLBACK_URL = 'http://681506cc3dfd.ngrok.io/text_messages/delivery_status'.freeze

  after_initialize :set_callback_url

  private

    def set_callback_url
      self.callback_url = CALLBACK_URL
    end
end
