class Ride < ActiveRecord::Base
  has_many :user_rides
  has_many :users, through: :user_rides

  enum status: ["active", "accepted", "in transit", "completed"]

  scope :active_requests, -> { where(status: "active") }
  scope :completed_rides, -> { where(status:3) }

  def requested_time
    self.created_at.strftime("%H:%M, %m/%d")
  end

  def rider
    users.where(role: 0).first
  end

  def driver
    users.where(role: 1).first
  end

  def has_driver?
    self.driver
  end

  def status_change_button
    if self.status == "active"
      "Accept"
    elsif self.status == "accepted"
      "Pick up Rider"
    elsif self.status == "in transit"
      "Complete Ride"
    end
  end

  def calculate_cost
    multiplier = (self.dropoff_time - self.pickup_time)/180
    (multiplier * 2).round(2)
  end
end
