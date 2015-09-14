json.array!(@trips) do |trip|
  json.extract! trip, :id, :origin, :destination, :date, :time, :seat, :price, :description, :city1, :country1, :city2, :country2, :lat1, :lng1, :lat2, :lng2, :list_stops, :user_id
  json.url trip_url(trip, format: :json)
end
