class AddCarCapacityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :car_capacity, :integer
  end
end
