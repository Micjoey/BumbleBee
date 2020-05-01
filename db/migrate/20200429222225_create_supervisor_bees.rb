class CreateSupervisorBees < ActiveRecord::Migration[5.1]
  def change
    create_table :supervisor_bees do |t|
      t.integer "bee_id", null: false
      t.integer "comb_id", null: false
      t.timestamps
    end
    add_index :supervisor_bees, :bee_id
    add_index :supervisor_bees, :comb_id
  end
end
