class User < ActiveRecord::Base
  has_secure_password
  has_many :user_rides
  has_many :rides, through: :user_rides

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

  #shared rider/driver methods
  def current_ride
    self.rides.where(status: [0,1,2]).first
  end

  #rider methods
  def has_active_rides?
    !self.current_ride.nil?
  end

  #driver methods
  def has_available_requests?
    !self.available_requests.empty?
  end

  def available_requests
    Ride.active_requests.where(num_passengers: (1..self.car_capacity).to_a)
  end
end
