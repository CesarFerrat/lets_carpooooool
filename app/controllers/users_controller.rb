class UsersController < ApplicationController

  def show
    @user = current_user
  end




  private
    def trip_params
      params.permit( :list_stops, :lat1, :lng1, :lat2, :lng2, :city1, :city2, :origin, :destination, :country1, :country2, :date, :time, :seat, :price, :description,)
    end

end
