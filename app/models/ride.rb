class Ride < ActiveRecord::Base
  has_many :user_rides
  has_many :users, through: :user_rides

  enum status: ["active", "accepted", "in transit", "completed"]

  scope :active_requests, -> { where(status: "active") }

  def requested_time
    self.created_at.strftime("%H:%M, %m/%d")
  end
end
