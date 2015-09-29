require 'rails_helper'

RSpec.describe User, type: :model do
  it "defaults to rider" do
   user = User.create(name: "Morgan",
                      email: "mm@gmail.com",
                      phone_number: "7274216505",
                      password: "password",
                      password_confirmation: "password")

    expect(user.rider?).to be_truthy
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

  it "knows its role" do
    rider = User.create(name: "Morgan",
      email: "mm@gmail.com",
      phone_number: "7274216505",
      password: "password",
      password_confirmation: "password")
    expect(rider).to be_valid

    driver = User.create(name: "Horace",
      email: "hw@gmail.com",
      phone_number: "1234567890",
      password: "password",
      password_confirmation: "password",
      role: 1)

    expect(rider.rider?).to be_truthy
    expect(rider.driver?).to be_falsey
    expect(driver.driver?).to be_truthy
    expect(driver.rider?).to be_falsey
  end
end
