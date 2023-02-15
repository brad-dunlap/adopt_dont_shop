class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def approved(app_id)
    pet_applications.where(application_id: app_id).first.pet_status
    # pet_applications.where(application_id: app_id).pluck(:pet_status).last
    # status == "Accepted"
    # PetApplication.find_by(pet_id: self.id, application_id: app_id).pet_status
  end
end
