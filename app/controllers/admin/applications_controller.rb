class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
		@application_pets = @application.pets
    @application_pet = PetApplication.find_by(pet: permitted_params[:pet_id], application: permitted_params[:id])

  end

  def update
    application = Application.find(params[:id])
    application_pet = PetApplication.find_by(pet: permitted_params[:pet_id], application: permitted_params[:id])
    if permitted_params[:status] == "approved"
      application.update!(status: "Approved")
    elsif permitted_params[:status] == "rejected"
      application.update!(status: "Rejected")
    end
    redirect_to "/admin/applications/#{application_pet.application.id}"
  end

  private

	def permitted_params
		params.permit(:id, :pet_id, :status)
	end
end