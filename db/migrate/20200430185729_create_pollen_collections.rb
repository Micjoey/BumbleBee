class CreatePollenCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :pollen_collections do |t|
      t.integer "bee_id", null: false
      t.integer "comb_id", null: false
      t.integer "nectar_consumption", null: false
      t.integer "pollen_glob_collected",
      t.timestamps
    end
     add_index :pollen_collections, :comb_id
    add_index :pollen_collections, :bee_id
    add_index :pollen_collections, :pollen_glob_collected
  end
end
