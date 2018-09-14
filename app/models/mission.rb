class Mission < ApplicationRecord
  # Validations
  validates :project_name, :description, :starting_date, :ending_date, :user, presence: true

  belongs_to :user

end
