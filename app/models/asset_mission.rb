class AssetMission < ApplicationRecord
  # Validations
  validates :user, :mission, :asset, presence: true

  belongs_to :asset
  belongs_to :mission
  belongs_to :user

end
