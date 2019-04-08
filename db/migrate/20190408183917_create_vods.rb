class CreateVods < ActiveRecord::Migration[5.2]
  def change
    create_table :vods do |t|
      t.integer :streamer_id
      t.integer :highlight_id
      t.integer :vod_id

      t.timestamps
    end
  end
end
