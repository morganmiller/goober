require 'rails_helper'

feature 'Rider seeking ride' do
  let(:rider) {User.create(name: "Morgan",
                           email: "mm@gmail.com",
                           phone_number: "7274216505",
                           password: "password",
                           password_confirmation: "password")
                        }

  scenario "can request a new ride" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(rider)

    visit root_path
    click_on "Request a Ride"
    expect(current_path).to eq(new_ride_path)

    fill_in "Pickup address", with: "1234 Main St., Denver CO, 80122"
    fill_in "Dropoff address", with: "5678 Main St., Denver CO, 80122"
    fill_in "ride_num_passengers", with: "3"
    click_on "Submit"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Current Ride Request")
    expect(page).to have_content("Status: Active")
  end
end
