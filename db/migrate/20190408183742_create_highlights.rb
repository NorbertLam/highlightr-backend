class CreateHighlights < ActiveRecord::Migration[5.2]
  def change
    create_table :highlights do |t|
      t.integer :vod_id
      t.integer :twitch_id
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
