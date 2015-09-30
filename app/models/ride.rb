class Ride < ActiveRecord::Base
  has_many :user_rides
  has_many :users, through: :user_rides

  enum status: ["active", "accepted", "in transit", "completed"]

  scope :active_requests, -> { where(status: "active") }

  def requested_time
    self.created_at.strftime("%H:%M, %m/%d")
  end

  def has_driver?
    !self.driver_id.nil?
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
end
