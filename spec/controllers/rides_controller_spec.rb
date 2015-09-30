require 'rails_helper'

RSpec.describe RidesController, :type => :controller do
  describe "#create" do
    let!(:user) { User.create(name: "Morgan",
                              email: "mm@gmail.com",
                              phone_number: "7274216505",
                              password: "password",
                              password_confirmation: "password")}

    it "creates a ride for the current user" do
      controller.stub(:current_user).and_return(user)
      params = {ride: {pickup_address: "here",
                        dropoff_address: "there",
                        num_passengers: 3}}
      post :create, params

      expect(response).to have_http_status(302)
      expect(user.rides.first.dropoff_address).to eq("there")
    end

    it "renders error for user who already has ride" do
      controller.stub(:current_user).and_return(user)
      request.env["HTTP_REFERER"] = "/"
      ride = Ride.create(pickup_address: "valid ride",
                        dropoff_address: "is this",
                        num_passengers: 1)

      user.rides << ride
      params = {ride: {pickup_address: "here",
                      dropoff_address: "there",
                      num_passengers: 3}}
      post :create, params

      expect(response.body).to eq("<html><body>You are being <a href=\"/\">redirected</a>.</body></html>")
      expect(user.rides.length).to eq(1)
      expect(user.rides.first.pickup_address).to eq("valid ride")
    end
  end
end
