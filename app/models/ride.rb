class Ride < ActiveRecord::Base
  has_many :user_rides
  has_many :users, through: :user_rides

  enum status: ["active", "accepted", "in transit", "completed"]

  scope :active_requests, -> { where(status: "active") }
  scope :completed_rides, -> { where(status:3) }

  def format_time(time)
    time.strftime('%B %d, %Y %l:%M %p')
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

  def send_most_recent_time
    if self.status == "active"
      format_time(self.created_at)
    elsif self.status == "accepted"
      format_time(self.accepted_time)
    elsif self.status == "in transit"
      format_time(self.pickup_time)
    elsif self.status == "completed"
      format_time(self.dropoff_time)
    end
  end
end
