class CreateCombs < ActiveRecord::Migration[5.2]
  def change
    create_table :combs do |t|
      t.integer "nectar_volume"
      t.integer "bee_id"
      t.integer "supervisor_bee_id", null: false
      t.timestamps
    end
    add_index :combs, :nectar_volume
    add_index :combs, :bee_id
    add_index :combs, :supervisor_bee_id
  end
end
