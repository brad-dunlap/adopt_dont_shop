require 'rails_helper'

RSpec.describe "Admin Shelters Index" do
  describe "Shelters index" do
    it 'shows all Shelters listed in reverse alphabetical order' do 
			@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
			@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
			@shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      
			visit '/admin/shelters'
			
			expect(@shelter_2.name).to appear_before(@shelter_1.name)
		end
		
		it 'shows Shelters with pending applications' do
			@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
			@shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @pickles = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    	@app1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, status: 1)
			@app_pet = PetApplication.create!(pet: @pickles, application: @app1)
    
			visit "/admin/shelters"

			expect(page).to have_content(@shelter_1.name)
			expect(page).to have_content(@shelter_2.name)
			
			within("section#pending_apps") do
				expect(page).to have_content("Shelters with Pending Applications")
				expect(page).to have_content(@shelter_1.name)
				expect(page).to_not have_content(@shelter_2.name)
			end
		end
	end
end