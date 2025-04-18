# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"
Bill.delete_all
Deposit.delete_all
Apartment.delete_all
User.delete_all

# Crear usuarios
User.create!(
  name_community: "Edificio La Providencia",
  type_community: "Departamento",
  saldo_inicial: 0,
  name: "Carlos Santana",
  email: "carlos.santana@gmail.com",
  password: "123456",
  role: "admin"
)

puts "Se creo #{User.count} usuario."

admin = User.last
puts "Id del administrador creado: #{admin.id}"
admin_id = admin.id

Apartment.create!(
  number: "101",
  description: "Verónica del Valle",
  user_id: admin_id
)
Apartment.create!(
  number: "102",
  description: "Jaime Alvarado",
  user_id: admin_id
)
Apartment.create!(
  number: "201",
  description: "Rosa Alarcón",
  user_id: admin_id
)
Apartment.create!(
  number: "202",
  description: "",
  user_id: admin_id
)
Apartment.create!(
  number: "301",
  description: "Carlos Santana",
  user_id: admin_id
)
Apartment.create!(
  number: "302",
  description: "Máximo Fierro",
  user_id: admin_id
)
Apartment.create!(
  number: "401",
  description: "Paulina Díaz",
  user_id: admin_id
)
Apartment.create!(
  number: "402",
  description: "",
  user_id: admin_id
)
Apartment.create!(
  number: "501",
  description: "",
  user_id: admin_id
)
Apartment.create!(
  number: "502",
  description: "",
  user_id: admin_id
)

puts "Se crearon #{Apartment.count} departamentos."
