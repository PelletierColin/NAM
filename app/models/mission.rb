class Mission < ApplicationRecord
  # Validations
  validates :project_name, :description, :starting_date, :ending_date, :user, presence: true
  validate :starting_ending_date_validation

  belongs_to :user

  def starting_ending_date_validation
    if starting_date > ending_date
      errors.add(:base, "can't be anterior the starting date")
    end
  end

end
