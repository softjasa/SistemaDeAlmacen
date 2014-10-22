class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :id_order
      t.string :product_name
      t.integer :quantity
      t.string :description
      t.string :code
      t.integer :price
      t.integer :total_price
      t.timestamps
    end
  end
end
