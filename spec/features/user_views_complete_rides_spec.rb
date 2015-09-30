require 'rails_helper'

feature 'Driver with completed rides' do
  let(:driver) {
    User.create(name: "Horace",
      email: "hw@gmail.com",
      phone_number: "1234567890",
      password: "password",
      password_confirmation: "password",
      role: 1,
      car_make: "Jeep",
      car_model: "Cherokee",
      car_capacity: 4)
  }

  let(:rider) {User.create(name: "Morgan",
    email: "mm@gmail.com",
    phone_number: "7274216505",
    password: "password",
    password_confirmation: "password")
  }

  let(:active_ride) {Ride.create(pickup_address: "destination number 9",
    dropoff_address: "not sure if that's a thing",
    num_passengers: 3)
  }

  scenario "can see them on dashboard" do
    rider.rides << active_ride

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(driver)
    visit root_path
    click_on("Accept")
    click_on("Pick up Rider")
    click_on("Complete Ride")

    within("#completed-rides") do
      expect(page).to have_content("destination number 9")
      expect(page).to have_content("not sure if that's a thing")
    end
  end
end
