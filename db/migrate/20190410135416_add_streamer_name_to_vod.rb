class AddStreamerNameToVod < ActiveRecord::Migration[5.2]
  def change
    add_column :vods, :login, :string
  end
end
