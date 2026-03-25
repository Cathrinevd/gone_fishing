class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders, dependent: :nullify

  validates :street, :city, :postal_code, :country, presence: true
end
