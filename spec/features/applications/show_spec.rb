require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, description: "I need a friend", status: "Pending")
    PetApplication.create!(pet: pickles, application: app_1)

    visit "/applications/#{app_1.id}"
  
    expect(page).to have_content(app_1.name)
    expect(page).to have_content(app_1.street_address)
    expect(page).to have_content(app_1.city)
    expect(page).to have_content(app_1.state)
    expect(page).to have_content(app_1.zip_code)
    expect(page).to have_content(app_1.description)
    expect(page).to have_content(app_1.pets.name)
    expect(page).to have_content(app_1.status)
  end

	it 'can search for pets to add to application' do
		shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, description: "I need a friend")
    
		visit "/applications/#{app_1.id}"

		expect(page).to have_content("Add a Pet to this Application")
				
		fill_in 'Search for Pet by name!', with: 'Ms. Pickles'
		click_button 'Submit'
		expect(current_path).to eq("/applications/#{app_1.id}")
		expect(page).to have_content("Ms. Pickles")

	end
end
