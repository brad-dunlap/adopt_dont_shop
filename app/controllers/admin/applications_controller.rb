class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
		@application_pets = @application.pets
  end

  def update
    @application = Application.find(params[:id])
    application_pet = PetApplication.find_pet_apps(params[:id], params[:pet_id])
    application_pet.update(pet_status: params[:status].to_i)
   
    redirect_to "/admin/applications/#{@application.id}"
  end
end