class Asset < ApplicationRecord
  # Validations
  validates :description, :product_serial, :date_purchase, :user, presence: true

  belongs_to :user
end
