require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123)
    PetApplication.create!(pet: pickles, application: app_1)

    visit "/applications/#{app_1.id}"
  
    expect(page).to have_content(app_1.name)
    expect(page).to have_content(app_1.street_address)
    expect(page).to have_content(app_1.city)
    expect(page).to have_content(app_1.state)
    expect(page).to have_content(app_1.zip_code)
    expect(page).to have_content(app_1.pets.name)
    expect(page).to have_content(app_1.status)
  end

	it 'can search for pets to add to application' do
		shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123)
    
		visit "/applications/#{app_1.id}"

		expect(page).to have_content("Add a pet to your application!")
				
		fill_in 'Search for Pet by name!', with: 'Ms. Pickles'
		click_button 'Submit'
		expect(current_path).to eq("/applications/#{app_1.id}")
		expect(page).to have_content("Ms. Pickles")
	end

  it 'can add pets to an application' do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123)
    
		visit "/applications/#{app_1.id}"
				
		fill_in 'Search for Pet by name!', with: 'Ms. Pickles'
		click_button 'Submit'
    click_button "Adopt Ms. Pickles"

    expect(current_path).to eq("/applications/#{app_1.id}")

    within ('section#add_pets') do
      expect(page).to have_content('Ms. Pickles')
    end
  end

	it 'can add descrition as to reason for adoption' do
		shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123)
    
		visit "/applications/#{app_1.id}"
				
		fill_in 'Search for Pet by name!', with: 'Ms. Pickles'
		click_button 'Submit'
    click_button "Adopt Ms. Pickles"

		within ('section#submit_application') do
      expect(page).to have_content("Why would you make a good owner for these pet(s)?")
			fill_in "Why would you make a good owner for these pet(s)?", with: "test information"
			click_button 'Submit Application'
		end

			expect(current_path).to eq("/applications/#{app_1.id}")
			expect(page).to have_content("Pending")		
	end
end
