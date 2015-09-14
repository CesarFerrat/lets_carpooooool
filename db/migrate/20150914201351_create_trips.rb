class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :origin
      t.string :destination
      t.datetime :date
      t.datetime :time
      t.integer :seat
      t.integer :price
      t.text :description
      t.string :city1
      t.string :country1
      t.string :city2
      t.string :country2
      t.string :lat1
      t.string :lng1
      t.string :lat2
      t.string :lng2
      t.string :list_stops
      t.references :user, index: true

      t.timestamps
    end
  end
end
