require 'rails_helper'

feature 'Rider seeking ride' do
  let(:rider) {User.create(name: "Morgan",
                           email: "mm@gmail.com",
                           phone_number: "7274216505",
                           password: "password",
                           password_confirmation: "password")
                        }

  let(:driver) {    User.create(name: "Horace",
                                email: "hw@gmail.com",
                                phone_number: "1234567890",
                                password: "password",
                                password_confirmation: "password",
                                role: 1,
                                car_make: "Jeep",
                                car_model: "Cherokee",
                                car_capacity: 4)}

  let(:ride) {Ride.create(pickup_address: "a place",
                          dropoff_address: "a different place",
                          num_passengers: 3)}

  scenario "can request a new ride" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(rider)

    visit root_path
    click_on "Request a Ride"
    expect(current_path).to eq(new_ride_path)

    fill_in "Pickup address", with: "this is pickup"
    fill_in "Dropoff address", with: "this is dropoff"
    fill_in "ride_num_passengers", with: "3"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Current Ride Request")
    expect(page).to have_content("this is pickup")
    expect(page).to have_content("this is dropoff")
  end

  scenario "sees driver info when a request ride has been accepted" do
    rider.rides << ride

    visit root_path
    click_on "Login"

    fill_in "Email", with: driver.email
    fill_in "Password", with: "password"
    click_button "Login"
    click_on "Accept"
    click_on "Logout"
    click_on "Login"
    fill_in "Email", with: rider.email
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Current Ride Request")
    expect(page).to have_content("Driver: Horace")
    expect(page).to have_content("Car Make: Jeep")
    expect(page).to have_content("Car Model: Cherokee")
  end
end
