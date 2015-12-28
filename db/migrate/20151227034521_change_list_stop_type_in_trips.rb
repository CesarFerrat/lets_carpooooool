class ChangeListStopTypeInTrips < ActiveRecord::Migration
  def change
    change_column :trips, :list_stops, :text
  end
end
