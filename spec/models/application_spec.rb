require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'instance methods' do
    it '#has_pets?' do
      shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
      app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123)
      
      expect(app_1.has_pets?).to be false
      
      pickles = app_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles', shelter_id: shelter_1.id)
      expect(app_1.has_pets?).to be true
    end
  end
end