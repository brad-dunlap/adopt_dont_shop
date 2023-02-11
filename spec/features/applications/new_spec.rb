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

		click_button "Submit Application"
		application = Application.last

		expect(current_path).to eq("/applications/#{application.id}")
		expect(page).to have_content(application.name)
		expect(page).to have_content(application.status)
	end

	it 'displays error message when required fields are not filled in' do
    visit '/applications/new'

		fill_in "Name", with: "Bobby"
		fill_in "Street Address", with: "123 Fake Street"
		fill_in "City", with: "Denver"
		fill_in "State", with: "CO"

    click_button 'Submit Application'
    expect(page).to have_current_path('/applications/new')
		expect(page).to have_content("Zip code can't be blank")
		expect(page).to have_content("Zip code is not a number")
  end
end