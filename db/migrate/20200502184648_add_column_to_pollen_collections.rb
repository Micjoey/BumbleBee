class AddColumnToPollenCollections < ActiveRecord::Migration[5.2]
  def change
    add_column :pollen_collections, :advisement, :string
  end
end
