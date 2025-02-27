class AddNameToContracts < ActiveRecord::Migration[8.0]
  def change
    add_column :contracts, :name, :string
  end
end
