class CreateTextMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :text_messages do |t|
      t.string :from_number
      t.string :to_number, null: false
      t.text :message, null: false
      t.string :callback_url

      t.integer :provider_id
      t.string :provider_status
      t.string :provider_message_id

      t.timestamps
    end
  end
end
