require 'rails_helper'

feature 'Logged in user' do
  let(:rider) {User.create(name: "Morgan",
                           email: "mm@gmail.com",
                           phone_number: "7274216505",
                           password: "password",
                           password_confirmation: "password")
                        }

  scenario "logs out and is redirected to signup" do
    visit root_path
    expect(current_path).to eq('/signup')
    click_on "Login"

    fill_in "Email", with: rider.email
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(root_path)
    click_on "Logout"

    expect(current_path).to eq('/signup')
    visit root_path
    expect(current_path).to eq('/signup')
  end
end
