class AssetMission < ApplicationRecord
  # Validations
  validates :user, :mission, :asset, presence: true
  validate :one_asset_per_mission_at_a_time

  belongs_to :asset
  belongs_to :mission
  belongs_to :user

  def one_asset_per_mission_at_a_time
    if self.mission
      if Mission.joins(:assets).where('assets.id =  ?', self.asset_id).where('ending_date >= ?', DateTime.now).count > 0
        errors.add(:base, "An asset can only belongs to one mission at a time.")
      end
    end
  end

end
