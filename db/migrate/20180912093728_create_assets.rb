class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.text :description
      t.text :product_serial
      t.time :battery_life
      t.belongs_to :user, index: true
      t.datetime :date_purchase
      t.timestamps
    end
  end
end
