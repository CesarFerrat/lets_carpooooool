class AddVerifiedIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified_id, :boolean
  end
end
