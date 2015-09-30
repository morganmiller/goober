class AddCostToRide < ActiveRecord::Migration
  def change
    add_column :rides, :cost, :float
  end
end
