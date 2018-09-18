class ChangeAssetsColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :assets, :battery_life, :integer
    change_column :asset_missions, :measurement_duration, :integer
    change_column :asset_missions, :measurement_interval, :integer
  end
end
