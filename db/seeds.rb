# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)
shelter2 = Shelter.create!(foster_program: false, name: "Dog Heaven", city: "Denver", rank: 2)
scooby = shelter1.pets.create!(adoptable: true, age: 4, breed: "Great Dane", shelter_id: 1, name: 'Scooby', )
scrappy = shelter1.pets.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: 1, name: 'Scrappy', )


