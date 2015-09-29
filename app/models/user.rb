class User < ActiveRecord::Base
  has_secure_password
  enum role: %w(rider driver)

  validates :name,            presence: true
  validates :email,           presence: true,
                              uniqueness: true,
                              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :phone_number,    presence: true,
                              uniqueness: true,
                              numericality: true,
                              length: { minimum: 10, maximum: 10 }
  validates :password_digest, presence: true

  validates_presence_of :car_make, if: ->(user) { user.role == 'driver' }
  validates_presence_of :car_model, if: ->(user) { user.role == 'driver' }
  validates_presence_of :car_capacity, if: ->(user) { user.role == 'driver' }

  def rider?
    self.role == "rider"
  end

  def driver?
    self.role == "driver"
  end
end
