class CreateStreamers < ActiveRecord::Migration[5.2]
  def change
    create_table :streamers do |t|
      t.string :twitch_id
      t.string :login
      t.string :display_name
      t.string :broadcaster_type
      t.string :description
      t.string :profile_image_url
      t.string :offline_image_url

      t.timestamps
    end
  end
end
