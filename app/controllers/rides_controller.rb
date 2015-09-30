class RidesController < ApplicationController
  def new
    @ride = Ride.new
  end

  def create
    ride = Ride.new(ride_params)
    if !current_user.has_active_rides?
      current_user.rides << ride
      redirect_to "/"
    else
      flash[:errors] = ride.errors.full_messages.join(",")
      redirect_to(:back)
    end
  end

private

  def ride_params
    params.require(:ride).permit(:pickup_location,
                                 :dropoff_location,
                                 :num_passengers)
  end
end
