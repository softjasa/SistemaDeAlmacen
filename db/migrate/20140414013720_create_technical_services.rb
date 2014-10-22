class CreateTechnicalServices < ActiveRecord::Migration
  def change
    create_table :technical_services do |t|
      t.string :product_code
      t.string :client
      t.string :status
      t.string :detail
      t.string :problems
      t.string :repairs
      t.string :product_name

      t.timestamps
    end
  end
end
