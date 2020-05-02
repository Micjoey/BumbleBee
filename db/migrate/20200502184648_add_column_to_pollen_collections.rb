class AddColumnToPollenCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :pollen_collections, :advisement, :integer
    add_column :pollen_collections, :advisement_accepted, :string

  end
end
