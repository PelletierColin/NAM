class CreateAssetMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :asset_missions do |t|
      t.time :measurement_interval
      t.time :measurement_duration
      t.text :placement_indications
      t.boolean :battery_replaced
      t.references :user
      t.references :mission
      t.references :asset
      t.timestamps
    end
  end
end
