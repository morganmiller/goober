class AddCarMakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :car_make, :string
  end
end
