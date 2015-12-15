class TripsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_trip, only: [:show, :edit, :update, :destroy]


  def home
		@user = User.new
	end

  def index
    @user = current_user
  	@trips = @user.trips
  end

  def getTrips
		@trips = current_user.trips
		render :json => @trips
 	end

  def show
    @trip = Trip.find_by(:id => params[:id])
		@origin = (@trip.origin).split(",")
		@lat1 = @origin[0]
		@lng1 = @origin[1]
		@destination = (@trip.destination).split(",")
		@lat2 = @destination[0]
		@lng2 = @destination[1]
		gon.lat1 = @lat1
		gon.lng1 = @lng1
		gon.lat2 = @lat2
		gon.lng2 = @lng2

		@comment = Comment.new
  end


  def removeTrip
    trip = Trip.find_by(:id => params[:id])
    trip.destroy
    render :status => 200, :json => {:response => "Confirmed"}
  end

  def form
    @lat1 = params[:lat1]
    @lng1 = params[:lng1]
    @lat2 = params[:lat2]
    @lng2 = params[:lng2]
    @city1 = params[:city1]
    @city2 = params[:city2]
    # @country1 = params[:country1]
    # @country2 = params[:country2]
    @user = User.new
    gon.lat1 = @lat1
    gon.lng1 = @lng1
    gon.lat2 = @lat2
    gon.lng2 = @lng2
  end


  def matchingTrips
    @lat1 = params[:ridelat1]
    @lng1 = params[:ridelng1]
    @lat2 = params[:ridelat2]
    @lng2 = params[:ridelng2]
    @city1 = params[:ridecity1]
    @city2 = params[:ridecity2]
    # @country1 = params[:country1]
    # @country2 = params[:country2]
    @user = User.new
    gon.lat1 = @lat1
    gon.lng1 = @lng1
    gon.lat2 = @lat2
    gon.lng2 = @lng2
    render '/trips/matchingtrips'
  end

  def search_matching
		@city1 = params[:ridecity1]
		@city2 = params[:ridecity2]
		trips = Trip.all
		collection = []
		matching_trips = []
		trips.each do |trip|
			if trip.return_stops.include?(@city1) && trip.return_stops.include?(@city2)
			matching_trips.push(trip)
			end
		end
    render(:status => 200, :json => matching_trips)
  end


  def direct_show
  	@trip = Trip.find_by(:id => params[:id])
  	@comment = @trip.comments.new
		@origin = (@trip.origin).split(",")
		@lat1 = @origin[0]
		@lng1 = @origin[1]
		@destination = (@trip.destination).split(",")
		@lat2 = @destination[0]
		@lng2 = @destination[1]
		gon.lat1 = @lat1
		gon.lng1 = @lng1
		gon.lat2 = @lat2
		gon.lng2 = @lng2

	  render 'show_trip_for_rider'
	end

	def add_comment
		@trip = Trip.find_by(:id => params[:id])
		@comment = @trip.comments.create(comment_params)
	end


  # def new
  #   @trip = Trip.new
  # end
  #
  # # GET /trips/1/edit
  # def edit
  # end
  #
  # # POST /trips
  # # POST /trips.json
  # def create
  #   @trip = Trip.new(trip_params)
  #   @trip.user = current_user
  #
  #   respond_to do |format|
  #     if @trip.save
  #       format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
  #       format.json { render :show, status: :created, location: @trip }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @trip.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /trips/1
  # # PATCH/PUT /trips/1.json
  # def update
  #   respond_to do |format|
  #     if @trip.update(trip_params)
  #       format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @trip }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @trip.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /trips/1
  # # DELETE /trips/1.json
  # def destroy
  #   @trip.destroy
  #   respond_to do |format|
  #     format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def comment_params
      params.require(:comment).permit(:title, :content)
    end

    def pretty_date(date)
        return date.strftime("%B %-d, %Y")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:origin, :destination, :date, :time, :seat, :price, :description, :city1, :country1, :city2, :country2, :lat1, :lng1, :lat2, :lng2, :list_stops, :user_id)
    end
end
