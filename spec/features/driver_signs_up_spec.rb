require 'rails_helper'

feature 'Unauthenticated user' do

  xscenario "is redirected to signup page and can sign up as a driver" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Driver"
    expect(current_path).to eq('/signup/driver')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace@turing.io"
    fill_in "Phone Number", with: "5555555555"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    fill_in "Car Make", with: "Ford"
    fill_in "Car Model", with: "Expedition"
    fill_in "Passenger Capacity", with: "7"
    click_button "Register"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Driver Dashboard"
    expect(page).to_not have_content "Rider Dashboard"
  end

  xscenario "can't sign up with invalid credentials" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Rider"
    expect(current_path).to eq('/signup/driver')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace"
    fill_in "Phone Number", with: "555555"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    fill_in "Car Make", with: "Ford"
    fill_in "Car Model", with: "Expedition"
    fill_in "Passenger Capacity", with: "7"
    click_button "Register"

    expect(current_path).to eq('/signup/driver')
    expect(page).to have_content "Invalid Email"
    expect(page).to have_content "Invalid Phone Number"
  end
end
