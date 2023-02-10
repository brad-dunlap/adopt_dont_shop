class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
	attribute :status, :string, default: 'In Progress'
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true 
  validates :zip_code, presence: true, numericality: true
end