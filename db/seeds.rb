class Seed
  def initialize
    create_riders
    create_drivers
    create_rides
  end

  def create_riders
  @rider =  User.create(name: "Morgan",
                email: "mm@gmail.com",
                phone_number: "7274216505",
                password: "password",
                password_confirmation: "password")
  end

  def create_drivers
    @driver = User.create(name: "Horace",
                          email: "hw@gmail.com",
                          phone_number: "1234567890",
                          password: "password",
                          password_confirmation: "password",
                          role: 1,
                          car_make: "Jeep",
                          car_model: "Cherokee",
                          car_capacity: 4)
  end

  def create_rides
    ride = Ride.create!(pickup_address: "a place",
                   dropoff_address: "a different place",
                   num_passengers: 3, status: 1)

    ride2 = Ride.create!(pickup_address: "ride 2",
                    dropoff_address: "ride 2 destination",
                    num_passengers: 3, status: 3)

    ride3 = Ride.create!(pickup_address: "ride 3",
                    dropoff_address: "ride 3 destination",
                    num_passengers: 3, status: 3)

    ride4 = Ride.create!(pickup_address: "ride 4",
                    dropoff_address: "ride 4 destination",
                    num_passengers: 3, status: 3)
  end
end

Seed.new
