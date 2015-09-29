class User < ActiveRecord::Base
  has_secure_password
  validates :name,            presence: true
  validates :email,           presence: true,
                              uniqueness: true,
                              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :phone_number,    presence: true,
                              uniqueness: true,
                              numericality: true,
                              length: { minimum: 10, maximum: 10 }
  validates :password_digest, presence: true

  
end
