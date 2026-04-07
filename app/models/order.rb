class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, :tax_amount, :total_amount, presence: true

  def self.ransackable_associations(_auth_object = nil)
    ["address", "order_items", "products", "user"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "user_id", "address_id", "status", "subtotal", "tax_amount", "total_amount",
     "created_at", "updated_at"]
  end
end
