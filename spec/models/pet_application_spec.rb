require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe '#class_methods' do

    before do
      @shelter_1 = Shelter.create!(foster_program: true, name: 'Fuzzy Friends', city: 'Denver', rank: 1)
      @app_1 = Application.create!(name: 'Bobby Luly', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, status: 1)
      @app_2 = Application.create!(name: 'Brad Dunlap', street_address: '124 Sesame Street', city: 'Denver', state: 'CO', zip_code: 80123, status: 1)
      @pet_1 = @app_1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Shorthair', name: 'Ms. Pickles', shelter_id: @shelter_1.id)
      @pet_2 = @app_2.pets.create!(adoptable: true, age: 3, breed: 'Maine Coon', name: 'Kitty', shelter_id: @shelter_1.id)
      @pet_app_1 = PetApplication.create(application: @app_1, pet: @pet_1)
      @pet_app_2 = PetApplication.create(application: @app_2, pet: @pet_2)
      
    end

    it '#find_pet_apps' do
      expect(PetApplication.find_pet_apps(@app_1.id, @pet_1.id)).to eq(@pet_app_1)
      expect(PetApplication.find_pet_apps(@app_1.id, @pet_2.id)).to_not eq(@pet_app_2)

      expect(PetApplication.find_pet_apps(@app_2.id, @pet_2.id)).to eq(@pet_app_2)
      expect(PetApplication.find_pet_apps(@app_2.id, @pet_2.id)).to_not eq(@pet_app_1)
    end
  end
end