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
Product.create!(
  name: "Ugly Stik GX2 Rod",
  description: "A strong and sensitive rod ideal for beginners and experienced anglers.",
  price: 69.99,
  stock: 12,
  brand: "Ugly Stik",
  category: rods
)

Product.create!(
  name: "Shimano Sedona Reel",
  description: "A smooth spinning reel with durable construction.",
  price: 99.99,
  stock: 6,
  brand: "Shimano",
  category: reels
)

Product.create!(
  name: "Spinnerbait Lure",
  description: "A versatile lure for catching bass in various conditions.",
  price: 8.99,
  stock: 30,
  brand: "Strike King",
  category: lures
)

Product.create!(
  name: "Soft Plastic Worms",
  description: "Flexible bait designed to mimic real worms for freshwater fishing.",
  price: 5.99,
  stock: 50,
  brand: "Berkley",
  category: lures
)

Product.create!(
  name: "Fishing Hook Kit",
  description: "A variety pack of hooks for different fishing styles.",
  price: 14.99,
  stock: 20,
  brand: "Eagle Claw",
  category: tackle
)

Product.create!(
  name: "Fishing Line 10lb",
  description: "Strong monofilament fishing line suitable for most freshwater fishing.",
  price: 11.99,
  stock: 40,
  brand: "Trilene",
  category: tackle
)