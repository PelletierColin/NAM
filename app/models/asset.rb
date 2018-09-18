class Asset < ApplicationRecord
  # Validations
  validates :description, :product_serial, :date_purchase, :user, :asset_type, presence: true

  belongs_to :user
  belongs_to :asset_type
  has_many :asset_missions
  has_many :missions, through: :asset_missions


  ## Return remaining battery hours at NOW
  def get_battery_status
    battery_tlived = (DateTime.now.to_i - date_purchase.to_i) / 3600
    battery_state = battery_life - battery_tlived
    if battery_state < 0
      battery_state = 0
    end
    return battery_state.to_i
  end

  ## Return remaining battery % at NOW
  def get_battery_status_pct
    battery_state = get_battery_status * 100 / battery_life
    if battery_state < 0
      battery_state = 0
    end
    return battery_state
  end

end
