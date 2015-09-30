require 'rails_helper'

RSpec.describe Ride, type: :model do
  it "has and differentiates between riders and drivers" do
    rider = User.create(name: "Morgan",
                        email: "mm@gmail.com",
                        phone_number: "7274216505",
                        password: "password",
                        password_confirmation: "password")
    driver = User.create(name: "Horace",
                        email: "hw@gmail.com",
                        phone_number: "1234567890",
                        password: "password",
                        password_confirmation: "password",
                        role: 1,
                        car_make: "Jeep",
                        car_model: "Cherokee",
                        car_capacity: 4)
    ride = Ride.create(pickup_address: "a place",
                      dropoff_address: "a different place",
                      num_passengers: 3)

    rider.rides << ride
    driver.rides << ride

    expect(rider.rides.first).to eq(ride)
    expect(driver.rides.first).to eq(ride)
    expect(ride.users).to eq([rider, driver])

    expect(ride.rider).to eq(rider)
    expect(ride.driver).to eq(driver)
  end

  it "needs a pickup location" do
    ride = Ride.new(dropoff_address: "a different place",
                    num_passengers: 3)

    expect(ride).to_not be_valid
  end

  it "needs a dropoff location" do
    ride = Ride.new(pickup_address: "a place",
                    num_passengers: 3)
    expect(ride).to_not be_valid
  end

  it "validates the number of passengers is a number" do
    ride = Ride.new(pickup_address: "a place",
                    dropoff_address: "a different place",
                    num_passengers: "three")

    expect(ride).to_not be_valid

    ride2 = Ride.new(pickup_address: "a place",
                     dropoff_address: "a different place",
                     num_passengers: 3)
    expect(ride2).to be_valid
  end

  it "scopes active requests" do
    ride = Ride.create(pickup_address: "a place",
                       dropoff_address: "a different place",
                       num_passengers: 3)

    accepted_ride = Ride.create(pickup_address: "a place",
                                dropoff_address: "a different place",
                                num_passengers: 3,
                                status: 1)

    expect(Ride.active_requests).to include(ride)
    expect(Ride.active_requests).to_not include(accepted_ride)
  end

  it "scopes completed rides" do
    ride = Ride.create(pickup_address: "a place",
                      dropoff_address: "a different place",
                      num_passengers: 3)

    completed_ride = Ride.create(pickup_address: "a place",
                                dropoff_address: "a different place",
                                num_passengers: 3,
                                status: 3)

    expect(Ride.completed_rides).to_not include(ride)
    expect(Ride.completed_rides).to include(completed_ride)
  end

  it "knows when it has a driver" do
    rider = User.create(name: "Morgan",
                        email: "mm@gmail.com",
                        phone_number: "7274216505",
                        password: "password",
                        password_confirmation: "password")
    driver = User.create(name: "Horace",
                        email: "hw@gmail.com",
                        phone_number: "1234567890",
                        password: "password",
                        password_confirmation: "password",
                        role: 1,
                        car_make: "Jeep",
                        car_model: "Cherokee",
                        car_capacity: 4)
    ride = Ride.create(pickup_address: "a place",
                        dropoff_address: "a different place",
                        num_passengers: 3)

    rider.rides << ride

    expect(ride.has_driver?).to be_falsey

    driver.rides << ride

    expect(ride.has_driver?).to be_truthy
  end

  it "knows the text for its status change button" do
    ride = Ride.create(pickup_address: "a place",
                      dropoff_address: "a different place",
                      num_passengers: 3)

    accepted_ride = Ride.create(pickup_address: "a place",
                                dropoff_address: "a different place",
                                num_passengers: 3,
                                status: 1)

    transit_ride = Ride.create(pickup_address: "a place",
                                dropoff_address: "a different place",
                                num_passengers: 3,
                                status: 2)

    expect(ride.status_change_button).to eq("Accept")
    expect(accepted_ride.status_change_button).to eq("Pick up Rider")
    expect(transit_ride.status_change_button).to eq("Complete Ride")
  end

  it "can calculate the cost of a ride once completed" do
    completed_ride = Ride.create(pickup_address: "a place",
                                  dropoff_address: "a different place",
                                  num_passengers: 3,
                                  status: 3,
                                  pickup_time: DateTime.parse("September 30, 2015 11:15 AM"),
                                  dropoff_time: DateTime.parse("September 30, 2015 11:30 AM"))

    expect(completed_ride.calculate_cost).to eq(10.0)
  end
end
