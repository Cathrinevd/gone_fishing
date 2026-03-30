# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.destroy_all
Product.destroy_all

rods = Category.create!(name: "Fishing Rods")
reels = Category.create!(name: "Reels")
lures = Category.create!(name: "Lures")
tackle = Category.create!(name: "Tackle")

Product.create!(
  name: "Shimano Spinning Rod",
  description: "A lightweight spinning rod designed for freshwater fishing.",
  price: 89.99,
  stock: 10,
  brand: "Shimano",
  category: rods
)

Product.create!(
  name: "Abu Garcia Reel",
  description: "A durable reel with smooth casting performance.",
  price: 79.99,
  stock: 8,
  brand: "Abu Garcia",
  category: reels
)

Product.create!(
  name: "Crankbait Lure",
  description: "A bright crankbait lure for attracting walleye and pike.",
  price: 12.99,
  stock: 25,
  brand: "Rapala",
  category: lures
)

Product.create!(
  name: "Tackle Box Organizer",
  description: "A compact tackle box with adjustable compartments.",
  price: 24.99,
  stock: 15,
  brand: "Plano",
  category: tackle
)