class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
	attribute :status, :string, default: 'In Progress'
end