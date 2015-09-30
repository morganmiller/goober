class RideManager
  def initialize(ride, driver)
    @ride = ride
    @current_status = ride.status
    @driver = driver
  end

  def update_ride
    if @current_status == "active"
      @driver.rides << @ride
      @ride.update_attributes(status: "accepted", accepted_time: Time.now, driver_id: @driver.id)
    elsif @current_status == "accepted"
      @ride.update_attributes(status: "in transit", pickup_time: Time.now)
    elsif @current_status == "in transit"
      @ride.update_attributes(status: "completed", dropoff_time: Time.now)
      @ride.update_attributes(cost: @ride.calculate_cost)
    else
      false
    end
  end
end
