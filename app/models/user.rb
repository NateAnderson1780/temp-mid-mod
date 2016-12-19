class User < ActiveRecord::Base
  has_secure_password
  has_many :links
  validates_presence_of :name
  validates_presence_of :email_address, uniqueness: true
  validates_presence_of :password
  validates_confirmation_of :password
end