class AssetMission < ApplicationRecord
  # Validations
  validates :user, :mission, :asset, :placed_at, presence: true
  validate :one_asset_per_mission_at_a_time
  validate :created_extracted_date_validation
  validate :all_position_required

  belongs_to :asset
  belongs_to :mission
  belongs_to :user

  def created_extracted_date_validation
    if placed_at && extracted_at && placed_at > extracted_at
      errors.add(:base, "can't be anterior the placed date")
    end
  end

  def one_asset_per_mission_at_a_time
    # if self.asset.has_current_mission && self.extracted_at_was != nil
    if asset.get_current_missions.length > 1
      asset.get_current_missions.each do |conflict_mission|
        errors.add(:base, 'Conflict with mission ' + conflict_mission.description)
        break
      end
    end
  end

  def all_position_required
    if position_x || position_y || position_z
      unless position_x && position_y && position_z
        errors.add(:base, 'All position fields should be defined')
      end
    end
  end
end
