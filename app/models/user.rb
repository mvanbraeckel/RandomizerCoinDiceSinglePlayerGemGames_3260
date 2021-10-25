class User < ApplicationRecord
  has_many :items, dependent: :destroy

  # todo -mvb- add validation for email format
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
