class Ride < ActiveRecord::Base
  has_many :user_rides
  has_many :users, through: :user_rides

  enum status: ["active", "accepted", "in transit", "completed"]
  validates :pickup_address, presence: true
  validates :dropoff_address, presence: true
  validates :num_passengers, presence: true, numericality: true

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
    case self.status
      when "active"
        "Accept"
      when "accepted"
        "Pick up Rider"
      when "in transit"
        "Complete Ride"
    end
  end

  def calculate_cost
    multiplier = (self.dropoff_time - self.pickup_time)/180
    (multiplier * 2).round(2)
  end

  def send_most_recent_time
    case self.status
      when "active"
        format_time(self.created_at)
      when "accepted"
        format_time(self.accepted_time)
      when "in transit"
        format_time(self.pickup_time)
      when "completed"
        format_time(self.dropoff_time)
    end
  end

  def update_ride_info
    directions = GoogleDirections.new(self.pickup_address, self.dropoff_address)
    update_attributes(distance: directions.distance_in_miles,
                      duration: directions.drive_time_in_minutes)
  end
end
