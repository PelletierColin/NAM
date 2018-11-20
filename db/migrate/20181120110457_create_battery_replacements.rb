class CreateBatteryReplacements < ActiveRecord::Migration[5.1]
  def change
    create_table :battery_replacements do |t|
      t.references :user
      t.references :asset
      t.timestamps
    end
  end
end
