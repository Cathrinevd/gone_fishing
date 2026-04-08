class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.ransackable_associations(_auth_object = nil)
    ["addresses", "orders"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "email", "first_name", "last_name", "created_at", "updated_at", "remember_created_at",
     "reset_password_sent_at", "reset_password_token"]
  end
end
