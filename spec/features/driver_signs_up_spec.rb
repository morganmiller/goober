require 'rails_helper'

feature 'Unauthenticated user' do

  scenario "is redirected to signup page and can sign up as a driver" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Driver"
    expect(current_path).to eq('/signup/driver')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace@turing.io"
    fill_in "Phone number", with: "5555555555"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Car make", with: "Ford"
    fill_in "Car model", with: "Expedition"
    fill_in "Car capacity", with: "7"
    click_button "Register"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome, Horace Williams"
    expect(page).to have_content "Driver Dashboard"
    expect(page).to_not have_content "Rider Dashboard"
  end

  scenario "can't sign up as driver with invalid credentials" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Driver"
    expect(current_path).to eq('/signup/driver')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace"
    fill_in "Phone number", with: "555555"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Car make", with: "Ford"
    fill_in "Car model", with: "Expedition"
    fill_in "Car capacity", with: "7"
    click_button "Register"

    expect(current_path).to eq('/signup/driver')
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "Phone number is too short (minimum is 10 characters)"
  end
end
