class CreateAssetTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :asset_types do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    add_reference :assets, :asset_type, index: true
  end
end
