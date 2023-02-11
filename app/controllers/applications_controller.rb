class ApplicationsController < ApplicationController

  def show
		@application = Application.find(params[:id])
		@pets = @application.pets
		if params[:search].present?
			@pet_search = Pet.search(params[:search])
		end
	end

	def new
	end

	def create
		application = Application.create(application_params)
		if application.save 
			redirect_to "/applications/#{application.id}"
		else
			flash[:notice] = error_message(application.errors)
			redirect_to '/applications/new'
		end
	end

private

	def application_params
		params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
	end
end