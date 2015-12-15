class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :users
  has_many :reservations
end
