class ApplicationsController < ApplicationController

  def show
		@application = Application.find(params[:id])
		@pets = @application.pets
	end

	def new
	end
end