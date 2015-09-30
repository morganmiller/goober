class Ride < ActiveRecord::Base
  belongs_to :user

  enum status: ["active", "accepted", "in transit", "completed"]

  scope :active_requests, -> { where(status: "active") }

  def requested_time
    self.created_at.strftime("%H:%M, %m/%d")
  end

  def has_driver?
    !self.driver_id.nil?
  end

  def self.with_driver(id)
    self.where(status: ["accepted", "in transit"], driver_id: id)
  end
end
