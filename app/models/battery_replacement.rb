class BatteryReplacement < ApplicationRecord
  validates :user, :asset, presence: true
  belongs_to :user
  belongs_to :asset
end
