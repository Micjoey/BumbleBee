class CreateWorkerBees < ActiveRecord::Migration[5.1]
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
  end
end
