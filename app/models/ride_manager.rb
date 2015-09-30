class RideManager
  def initialize(ride, new_status, driver)
    @ride = ride
    @new_status = new_status
    @driver = driver
  end

  def update_ride
    if @new_status == "accepted"
      @driver.rides << @ride
      @ride.update_attributes(status: @new_status, accepted_time: Time.now, driver_id: @driver.id)
    elsif @new_status == "in transit"
      @ride.update_attributes(status: @new_status, pickup_time: Time.now)
    elsif @new_status == "completed"
      @ride.update_attributes(status: @new_status, droppoff_time: Time.now)
    else
      false
    end
  end
end
