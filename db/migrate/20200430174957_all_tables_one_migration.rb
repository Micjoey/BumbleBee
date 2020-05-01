class AllTablesOneMigration < ActiveRecord::Migration[5.2]
  def change
    create_table :worker_bees do |t|
      t.integer "nectar"
      t.string "bee_name"
      t.integer "comb_id"
      t.timestamps
    end
    add_index :worker_bees, :nectar
    

    create_table :combs do |t|
      t.integer "sweet_spot", null: false
      t.integer "bee_id"
      t.timestamps
    end
    add_index :combs, :bee_id


    create_table :supervisor_bees do |t|
      t.integer "bee_id", null: false
      t.integer "comb_id", null: false
      t.timestamps
    end
    add_index :supervisor_bees, :bee_id
    add_index :supervisor_bees, :comb_id


  end
end