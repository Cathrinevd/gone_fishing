#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

Rails.logger.debug "Clearing old data..."

Product.destroy_all
Category.destroy_all

AdminUser.destroy_all
Rails.logger.debug "Seeding provinces..."

Province.upsert_all(
  [
    { name: "Alberta", code: "AB", gst: 0.05, pst: 0.0, hst: 0.0 },
    { name: "British Columbia", code: "BC", gst: 0.05, pst: 0.07, hst: 0.0 },
    { name: "Manitoba", code: "MB", gst: 0.05, pst: 0.07, hst: 0.0 },
    { name: "New Brunswick", code: "NB", gst: 0.0, pst: 0.0, hst: 0.15 },
    { name: "Newfoundland and Labrador", code: "NL", gst: 0.0, pst: 0.0, hst: 0.15 },
    { name: "Nova Scotia", code: "NS", gst: 0.0, pst: 0.0, hst: 0.15 },
    { name: "Northwest Territories", code: "NT", gst: 0.05, pst: 0.0, hst: 0.0 },
    { name: "Nunavut", code: "NU", gst: 0.05, pst: 0.0, hst: 0.0 },
    { name: "Ontario", code: "ON", gst: 0.0, pst: 0.0, hst: 0.13 },
    { name: "Prince Edward Island", code: "PE", gst: 0.0, pst: 0.0, hst: 0.15 },
    { name: "Quebec", code: "QC", gst: 0.05, pst: 0.01, hst: 0.0 },
    { name: "Saskatchewan", code: "SK", gst: 0.05, pst: 0.06, hst: 0.0 },
    { name: "Yukon", code: "YT", gst: 0.05, pst: 0.0, hst: 0.0 }
  ]
)

Rails.logger.debug "Creating categories..."

rods   = Category.find_or_create_by!(name: "Fishing Rods")
reels  = Category.find_or_create_by!(name: "Reels")
lures  = Category.find_or_create_by!(name: "Lures")
tackle = Category.find_or_create_by!(name: "Tackle")

Rails.logger.debug "Creating manual fishing products..."

Product.create!(
  name:        "Shimano Spinning Rod",
  description: "A lightweight spinning rod designed for freshwater fishing.",
  price:       89.99,
  stock:       10,
  brand:       "Shimano",
  category:    rods
)

Product.create!(
  name:        "Abu Garcia Reel",
  description: "A durable reel with smooth casting performance.",
  price:       79.99,
  stock:       8,
  brand:       "Abu Garcia",
  category:    reels
)

Product.create!(
  name:        "Crankbait Lure",
  description: "A bright crankbait lure for attracting walleye and pike.",
  price:       12.99,
  stock:       25,
  brand:       "Rapala",
  category:    lures
)

Product.create!(
  name:        "Tackle Box Organizer",
  description: "A compact tackle box with adjustable compartments.",
  price:       24.99,
  stock:       15,
  brand:       "Plano",
  category:    tackle
)

Product.create!(
  name:        "Ugly Stik GX2 Rod",
  description: "A strong and sensitive rod ideal for beginners and experienced anglers.",
  price:       69.99,
  stock:       12,
  brand:       "Ugly Stik",
  category:    rods
)

Product.create!(
  name:        "Shimano Sedona Reel",
  description: "A smooth spinning reel with durable construction.",
  price:       99.99,
  stock:       6,
  brand:       "Shimano",
  category:    reels
)

Product.create!(
  name:        "Spinnerbait Lure",
  description: "A versatile lure for catching bass in various conditions.",
  price:       8.99,
  stock:       30,
  brand:       "Strike King",
  category:    lures
)

Product.create!(
  name:        "Soft Plastic Worms",
  description: "Flexible bait designed to mimic real worms for freshwater fishing.",
  price:       5.99,
  stock:       50,
  brand:       "Berkley",
  category:    lures
)

Product.create!(
  name:        "Fishing Hook Kit",
  description: "A variety pack of hooks for different fishing styles.",
  price:       14.99,
  stock:       20,
  brand:       "Eagle Claw",
  category:    tackle
)

Product.create!(
  name:        "Fishing Line 10lb",
  description: "Strong monofilament fishing line suitable for most freshwater fishing.",
  price:       11.99,
  stock:       40,
  brand:       "Trilene",
  category:    tackle
)

Rails.logger.debug "Adding Faker products..."

categories = [rods, reels, lures, tackle]

(100 - Product.count).times do
  Product.create!(
    name:        Faker::Commerce.product_name,
    description: Faker::Lorem.sentence(word_count: 12),
    price:       Faker::Commerce.price(range: 10.0..200.0),
    stock:       rand(5..50),
    brand:       Faker::Commerce.brand,
    category:    categories.sample
  )
end

Rails.logger.debug "Done!"
Rails.logger.debug { "Categories: #{Category.count}" }
Rails.logger.debug { "Products: #{Product.count}" }
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end
