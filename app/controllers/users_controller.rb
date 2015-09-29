class UsersController < ApplicationController
  before_filter :authorize, only: [:show]

  def new

  end

  def rider_signup

  end

  def driver_signup

  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash[:errors] = user.errors.full_messages.join(",")
      redirect_to(:back)
    end
  end

  def show

  end

private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :phone_number,
                                 :password,
                                 :password_confirmation,
                                 :car_make,
                                 :car_model,
                                 :car_capacity,
                                 :role)
  end
end
