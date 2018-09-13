class Asset < ApplicationRecord
  # Validations
  validates :description, :product_serial, :date_purchase, :user, :asset_type, presence: true

  belongs_to :user
  belongs_to :asset_type

end
