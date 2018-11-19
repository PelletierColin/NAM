class AssetMission < ApplicationRecord
  # Validations
  validates :user, :mission, :asset, presence: true
  validate :one_asset_per_mission_at_a_time

  belongs_to :asset
  belongs_to :mission
  belongs_to :user

  def one_asset_per_mission_at_a_time
    if self.asset.has_current_mission && self.extracted_at_was != nil
      self.asset.get_current_missions.each do |conflict_mission|
        errors.add(:base, "Conflict with mission "+conflict_mission.description)
        break
      end
    end
  end
end
