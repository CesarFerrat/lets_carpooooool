class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :trip, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
