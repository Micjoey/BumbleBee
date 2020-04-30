class AllTablesOneMigration < ActiveRecord::Migration[5.2]
  def change
    create_table :worker_bees do |t|
      t.integer "pollen_globs"
      t.integer "nectar"
      t.string "bee_name"
      t.integer "comb_id"
      t.timestamps
    end
    add_index :worker_bees, :pollen_globs
    add_index :worker_bees, :nectar

    create_table :combs do |t|
      t.integer "nectar_volume"
      t.integer "bee_id"
      t.integer "supervisor_bee_id", null: false
      t.timestamps
    end
    add_index :combs, :nectar_volume
    add_index :combs, :bee_id
    add_index :combs, :supervisor_bee_id


    create_table :supervisor_bees do |t|
      t.integer "bee_id", null: false
      t.integer "comb_id", null: false
      t.timestamps
    end
    add_index :supervisor_bees, :bee_id
    add_index :supervisor_bees, :comb_id

  end
end
