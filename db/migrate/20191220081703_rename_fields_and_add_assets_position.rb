class RenameFieldsAndAddAssetsPosition < ActiveRecord::Migration[5.1]
  def change
    add_column :asset_missions, :placed_at, :datetime, null: true
    AssetMission.update_all('placed_at=created_at')

    add_column :asset_missions, :position_x, :integer
    add_column :asset_missions, :position_y, :integer
    add_column :asset_missions, :position_z, :integer

    rename_column :asset_missions, :placement_indications, :comments
  end
end
