class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :pickup_address
      t.string :dropoff_address
      t.integer :num_passengers
      t.integer :status, default: 0
      t.datetime :accepted_time
      t.datetime :pickup_time
      t.datetime :dropoff_time

      t.timestamps null: false
    end
  end
end
