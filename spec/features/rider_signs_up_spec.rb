require 'rails_helper'

feature 'Unauthenticated user' do

  scenario "is redirected to signup page and can sign up as a rider" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Rider"
    expect(current_path).to eq('/signup/rider')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace@turing.io"
    fill_in "Phone Number", with: "5555555555"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Register"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Rider Dashboard"
    expect(page).to_not have_content "Driver Dashboard"
  end

  xscenario "can't sign up with invalid credentials" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Rider"
    expect(current_path).to eq('/signup/rider')

    fill_in "Name", with: "Horace Williams"
    fill_in "Email", with: "horace"
    fill_in "Phone Number", with: "555555"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"
    click_button "Register"

    expect(current_path).to eq('/signup/rider')
    expect(page).to have_content "Invalid Email"
    expect(page).to have_content "Invalid Phone Number"
  end
end
