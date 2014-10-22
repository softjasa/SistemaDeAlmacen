class CreateProductorders < ActiveRecord::Migration
  def change
    create_table :productorders do |t|
      t.integer :productname_id
      t.integer :quantity
      t.boolean :ingresado
      t.float :price
      t.float :total_price
      t.references :order, index: true
      t.timestamps
    end
  end
end