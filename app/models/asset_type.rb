class AssetType < ApplicationRecord
  validates :name, :description, presence: true

  has_many :assets
end
