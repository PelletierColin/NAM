class AddDeletedToAssets < ActiveRecord::Migration[5.1]
  def change
    add_column :assets, :deleted, :boolean, default: false
  end
end
