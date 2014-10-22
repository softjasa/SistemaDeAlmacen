class CreateOutflows < ActiveRecord::Migration
  def change
    create_table :outflows do |t|
      t.integer :sale_id
      t.integer :total_price
      
      t.timestamps
    end
  end
end