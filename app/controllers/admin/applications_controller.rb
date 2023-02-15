class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
		@application_pets = @application.pets
    # @application_pet = PetApplication.find_by(pet: params[:pet_id], application: params[:id])

  end

  def update
    @application = Application.find(params[:id])
    application_pet = PetApplication.find_pet_apps(params[:id], params[:pet_id])
    
    application_pet.update(pet_status: params[:status].to_i)
    # if params[:pet_status] == 1
    #   application_pet.update!(pet_status: params[:pet_status].to_i)
    # elsif params[:pet_status] == 2
    #   application_pet.update!(pet_status: 2)
    # end
    redirect_to "/admin/applications/#{@application.id}"
  end

  private

	# def permitted_params
	# 	params.permit(:id, :pet_id, :pet_status)
	# end
end