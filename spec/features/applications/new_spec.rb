require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    
		visit "/applications/new"

		fill_in "Name", with: "Bobby"
		fill_in "Street Address", with: "123 Fake Street"
		fill_in "City", with: "Denver"
		fill_in "State", with: "CO"
		fill_in "Zipcode", with: "12345"
		fill_in "Why do you want to adopt?", with: "This is a description"

		click_button "Submit Application"
		application = Application.last

		expect(current_path).to eq("/applications/#{application.id}")
		expect(page).to have_content(application.name)
		expect(page).to have_content(application.description)
		expect(page).to have_content(application.status)
	end
end