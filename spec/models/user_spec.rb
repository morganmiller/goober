require 'rails_helper'

RSpec.describe User, type: :model do
  it "defaults to rider" do
   user = User.create(name: "Morgan",
                      email: "mm@gmail.com",
                      phone_number: "7274216505",
                      password: "password",
                      password_confirmation: "password")

    expect(user.role).to eq("rider")
  end

  it "only validates car info for driver" do
    rider = User.new(name: "Morgan",
                     email: "mm@gmail.com",
                     phone_number: "7274216505",
                     password: "password",
                     password_confirmation: "password")
    expect(rider).to be_valid

    driver = User.new(name: "Horace",
                      email: "hw@gmail.com",
                      phone_number: "1234567890",
                      password: "password",
                      password_confirmation: "password",
                      role: 1)
    expect(driver).to_not be_valid
  end

  it "saves a driver with car info" do
    driver = User.new(name: "Horace",
                      email: "hw@gmail.com",
                      phone_number: "1234567890",
                      password: "password",
                      password_confirmation: "password",
                      role: 1,
                      car_make: "Jeep",
                      car_model: "Cherokee",
                      car_capacity: 4)

    expect(driver).to be_valid
  end
end
