# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
vehicle_types = [
  { name: 'Sedan' },
  { name: 'SUV' },
  { name: 'Truck' },
  { name: 'Coupe' },
  { name: 'Convertible' },
  { name: 'Minivan' },
  { name: 'Hatchback' },
  { name: 'Wagon' },
  { name: 'Motorcycle' },
  { name: 'Electric' }
]

vehicle_types.each do |vehicle_type|
  VehicleType.create!(vehicle_type)
end

owners = [
  { name: 'John Doe', email: 'john.doe@example.com', contact_number: '1204507890', city: 'New York', state: 'NY', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Jane Smith', email: 'jane.smith@example.com', contact_number: '0907604321', city: 'Los Angeles', state: 'CA', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Alice Johnson', email: 'alice.johnson@example.com', contact_number: '5501204567', city: 'Chicago', state: 'IL', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Bob Brown', email: 'bob.brown@example.com', contact_number: '5507604321', city: 'Houston', state: 'TX', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Charlie Davis', email: 'charlie.davis@example.com', contact_number: '5506701234', city: 'Phoenix', state: 'AZ', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Diana Evans', email: 'diana.evans@example.com', contact_number: '5508705432', city: 'Philadelphia', state: 'PA', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Ethan Harris', email: 'ethan.harris@example.com', contact_number: '5502305678', city: 'San Antonio', state: 'TX', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Fiona Jackson', email: 'fiona.jackson@example.com', contact_number: '5507800123', city: 'San Diego', state: 'CA', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'George Kelly', email: 'george.kelly@example.com', contact_number: '5503406789', city: 'Dallas', state: 'TX', country: 'USA', created_at: Time.now, updated_at: Time.now },
  { name: 'Hannah Lewis', email: 'hannah.lewis@example.com', contact_number: '5505608901', city: 'San Jose', state: 'CA', country: 'USA', created_at: Time.now, updated_at: Time.now }
]

owners.each do |owner|
  Owner.create!(owner)
end

vehicles = [
  { registration_number: 'ABC123', owner_id: 1, vehicle_type_id: 1, base_price: 20000.00, price_per_km: 0.50, name: 'Toyota Camry', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A reliable and efficient sedan.' },
  { registration_number: 'XYZ789', owner_id: 2, vehicle_type_id: 2, base_price: 30000.00, price_per_km: 0.70, name: 'Ford Explorer', fuel_type: 'Diesel', created_at: Time.now, updated_at: Time.now, description: 'A robust and spacious SUV.' },
  { registration_number: 'LMN456', owner_id: 3, vehicle_type_id: 3, base_price: 25000.00, price_per_km: 0.60, name: 'Chevrolet Silverado', fuel_type: 'Diesel', created_at: Time.now, updated_at: Time.now, description: 'A powerful and durable truck.' },
  { registration_number: 'DEF123', owner_id: 4, vehicle_type_id: 4, base_price: 22000.00, price_per_km: 0.55, name: 'Honda Civic Coupe', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A stylish and sporty coupe.' },
  { registration_number: 'GHI456', owner_id: 5, vehicle_type_id: 5, base_price: 27000.00, price_per_km: 0.65, name: 'Mazda MX-5', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A fun and agile convertible.' },
  { registration_number: 'JKL789', owner_id: 6, vehicle_type_id: 6, base_price: 24000.00, price_per_km: 0.58, name: 'Chrysler Pacifica', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A comfortable and family-friendly minivan.' },
  { registration_number: 'MNO123', owner_id: 7, vehicle_type_id: 7, base_price: 21000.00, price_per_km: 0.52, name: 'Volkswagen Golf', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A compact and versatile hatchback.' },
  { registration_number: 'PQR456', owner_id: 8, vehicle_type_id: 8, base_price: 23000.00, price_per_km: 0.57, name: 'Subaru Outback', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A rugged and reliable wagon.' },
  { registration_number: 'STU789', owner_id: 9, vehicle_type_id: 9, base_price: 15000.00, price_per_km: 0.40, name: 'Harley-Davidson Sportster', fuel_type: 'Petrol', created_at: Time.now, updated_at: Time.now, description: 'A classic and iconic motorcycle.' },
  { registration_number: 'VWX123', owner_id: 10, vehicle_type_id: 10, base_price: 35000.00, price_per_km: 0.75, name: 'Tesla Model 3', fuel_type: 'Electric', created_at: Time.now, updated_at: Time.now, description: 'A cutting-edge and efficient electric car.' }
]

vehicles.each do |vehicle|
  Vehicle.create!(vehicle)
end
