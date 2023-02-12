class Admin::SheltersController < ApplicationController
	
	def index
		@shelters = Shelter.order_by_reverse_alphabetical
		@shelters_app_pending = Shelter.shelter_app_pending
	end
end