require 'rails_helper'

feature 'Driver seeking rides' do
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

  let(:rider2) {User.create(name: "Not Morgan",
                            email: "mmm@gmail.com",
                            phone_number: "0987654321",
                            password: "password",
                            password_confirmation: "password")
  }

  let(:active_ride) {Ride.create(pickup_address: "a place",
                                 dropoff_address: "a different place",
                                 num_passengers: 3)
  }

  let(:bad_ride) {Ride.create(pickup_address: "i won't show up",
                              dropoff_address: "because too many passengers",
                              num_passengers: 5)
  }

  scenario "can see a list of active rides with good num passengers their dashboard" do
    rider.rides << active_ride
    rider2.rides << bad_ride

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(driver)

    visit root_path
    expect(page).to have_content("Active Ride Requests")
    expect(page).to have_content("a place")
    expect(page).to have_content("a different place")
    expect(page).to have_button("Accept")

    expect(page).to_not have_content("i won't show up")
    expect(page).to_not have_content("because too many passengers")
  end

  scenario "can accept, pick up and complete a ride" do
    rider.rides << active_ride

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(driver)
    visit root_path
    click_on("Accept")

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Current Ride")
    expect(page).to have_content("a place")
    expect(page).to have_content("a different place")
    expect(page).to have_content("Status: Accepted")

    click_on("Pick up Rider")
    expect(page).to have_content("Current Ride")
    expect(page).to have_content("a place")
    expect(page).to have_content("a different place")
    expect(page).to have_content("Status: In transit")

    click_on("Complete Ride")
    expect(page).to_not have_content("Current Ride")
  end
end
