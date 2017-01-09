class User < ApplicationRecord
  has_secure_password
  has_many :links
  validates :email, presence: true, uniqueness: {message: "Email already in use"}
  validates_presence_of :password
  validates_confirmation_of :password
end
