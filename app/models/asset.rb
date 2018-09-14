class Asset < ApplicationRecord
  # Validations
  validates :description, :product_serial, :date_purchase, :user, :asset_type, presence: true

  belongs_to :user
  belongs_to :asset_type
  has_many :asset_missions
  has_many :missions, through: :asset_missions

end
