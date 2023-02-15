class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  enum pet_status: ["Pending", "Approved", "Rejected"]

  def self.find_pet_apps(app_id, pet_id)
    where(application_id: app_id, pet_id: pet_id).last
  end
end