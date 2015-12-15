class UsersController < ApplicationController

  def show
    @user = current_user
    @title = "Welcome #{@user.email}. This is your dashboard."

  end

  def showTrips
    @user = current_user
    @trips = @user.trips
    render 'showtrips'
  end

  def getTrips
    @trips = current_user.trips
    render :json => @trips
  end

  def createTrips
      p params
    trip = Trip.create(trip_params)
    current_user.trips.push(trip)
          render :json => trip, status: 200
  end

  def updateTripsWithStops
    # trip = Trip.find_by(:id => )
    trip = current_user.trips.find_by_id(params[:id])
    trip.list_stops.push(params[:city])
    trip.save
    render json: trip
  end

  private
    def trip_params
      params.permit( :lat1, :lng1, :lat2, :lng2, :city1, :city2, :origin, :destination, :country1, :country2, :date, :time, :seat, :price, :description,)
    end

end
