require 'rails_helper'

RSpec.describe 'Admin application show' do
  it "has a button to approve each pet, which disappears after being clicked, confirmation message" do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, status: "Pending")
    PetApplication.create!(pet: pickles, application: app_1)

    visit "/admin/applications/#{app_1.id}"

    expect(page).to have_button("Approve #{pickles.name}")

    click_button "Approve #{pickles.name}"

    expect(current_path).to eq("/admin/applications/#{app_1.id}")
    expect(page).to_not have_button("Approve #{pickles.name}")
    expect(page).to have_content("#{pickles.name}'s application is Approved")
  end

  it "has a button to reject each pet, which disappears after being clicked, confirmation message" do
    shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
    pickles = shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles')
    app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, status: "Pending")
    PetApplication.create!(pet: pickles, application: app_1)

    visit "/admin/applications/#{app_1.id}"

    expect(page).to have_button("Reject #{pickles.name}")

    click_button "Reject #{pickles.name}"

    expect(current_path).to eq("/admin/applications/#{app_1.id}")
    expect(page).to_not have_button("Reject #{pickles.name}")
    expect(page).to have_content("#{pickles.name}'s application is Rejected")
  end
end