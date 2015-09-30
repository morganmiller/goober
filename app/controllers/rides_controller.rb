class RidesController < ApplicationController
  before_filter :authorize
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

  def update
    ride = Ride.find(params[:id])
    if RideManager.new(ride, current_user).update_ride
      redirect_to "/"
    else
      flash[:errors] = "That ride cannot be updated at this time."
      redirect_to(:back)
    end
  end
private

  def ride_params
    params.require(:ride).permit(:pickup_address,
                                 :dropoff_address,
                                 :num_passengers)
  end
end
