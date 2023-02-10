# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all

application = Application.create!(name: 'Bobby Lully', street_address: '123 Sesame Street', city: 'Denver', state: 'CO', zip_code: 12345, description: "I need a friend", status: "Pending")
shelter1 = Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)
scooby = shelter1.pets.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: 1, name: 'Scooby', )
pet_application = PetApplication.create!(pet: scooby, application: application)


