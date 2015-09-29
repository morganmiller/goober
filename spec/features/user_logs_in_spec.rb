require 'rails_helper'

feature 'Authenticated user' do
  let(:rider) {User.create(name: "Morgan",
                           email: "mm@gmail.com",
                           phone_number: "7274216505",
                           password: "password",
                           password_confirmation: "password")
  }

  let(:driver) {User.create(name: "Horace",
                            email: "hw@gmail.com",
                            phone_number: "1234567890",
                            password: "password",
                            password_confirmation: "password",
                            role: 1,
                            car_make: "Jeep",
                            car_model: "Cherokee",
                            car_capacity: 4)
  }

  scenario "is able to login as a rider" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Login"

    fill_in "Email", with: rider.email
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome, #{rider.name}"
    expect(page).to have_content "Rider Dashboard"
    expect(page).to_not have_content "Driver Dashboard"
  end

  scenario "is able to login as a driver" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Login"

    fill_in "Email", with: driver.email
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome, #{driver.name}"
    expect(page).to have_content "Driver Dashboard"
    expect(page).to_not have_content "Rider Dashboard"
  end
end
