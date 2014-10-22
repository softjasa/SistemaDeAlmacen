class CreateSubproducts < ActiveRecord::Migration
  def change
    create_table :subproducts do |t|
      t.string :code
      t.boolean :available
      t.string :name
      t.references :product, index: true
      t.references :sale, index: true
      t.references :outflow, index: true

      t.timestamps
    end
  end
end
