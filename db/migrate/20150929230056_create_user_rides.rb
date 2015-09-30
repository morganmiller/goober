class CreateUserRides < ActiveRecord::Migration
  def change
    create_table :user_rides do |t|
      t.references :user, index: true, foreign_key: true
      t.references :ride, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
