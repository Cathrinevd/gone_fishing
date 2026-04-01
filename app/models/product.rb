class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :brand, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items", "orders", "image_attachment", "image_blob"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "stock", "brand", "category_id", "created_at",
     "updated_at"]
  end
end
