class AddExtractionDateMissionAsset < ActiveRecord::Migration[5.1]
  def change
    add_column :asset_missions, :extracted_at, :datetime, null: true
  end
end
