class AddCarModelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :car_model, :string
  end
end
