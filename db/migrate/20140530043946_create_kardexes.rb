class CreateKardexes < ActiveRecord::Migration
  def change
    create_table :kardexes do |t|
      t.date :date
      t.string :detail
      t.integer :income
      t.integer :output
      t.integer :residue
      t.references :product, index: true

      t.timestamps
    end
  end
end
