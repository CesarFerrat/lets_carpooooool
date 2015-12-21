class Trip < ActiveRecord::Base

  belongs_to :user
  has_many :users, :through => :reservations
  has_many :comments

  
  serialize :list_stops, Array

	validates 	:lat1, presence: true
	validates 	:lat2, presence: true
	validates 	:lng1, presence: true
	validates 	:lng2, presence: true
	validates	:date, presence: true
	validates	:time, presence: true
	validates	:seat,  presence: true, numericality: true
	validates	:price,  presence: true, numericality: true
	validates	:description,  presence: true

	# reverse_geocoded_by :lat1, :lon2 do |obj,results|
 #  		if geo = results.first
 #    	obj.city    = geo.city
 #    	obj.country = geo.country_code
 #  		end
	# end

	# after_validation :reverse_geocode
  def return_stops
  	cities = []
  	Trip.last.list_stops.each do |address|
  		cities.push(address.split(', '))
  	end
	  items = []
	  cities.each do |collection|
		collection.each do |item|
		items.push(item)
	  end
	  end
	  items
  end

end
