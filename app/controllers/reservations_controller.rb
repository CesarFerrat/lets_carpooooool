class ReservationsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # def reserve
	# 	trip = Trip.find_by(:id => params[:id])
 #    	if user_signed_in?
	#     	unless trip.users.include?(current_user)
	#       		trip.users.push(current_user)
	#       		render :status => 200, :json => {:response => "Joined Tournament"}
	#     	else
	#       		render :status => 400, :json => {:response => "Attempt failed"}
	#     	end
	#     end
	# end

	# def unreserve
	# 	trip = Trip.find_by(:id => params[:id])
 #    	if user_signed_in?
 #      		trip.users.delete(current_user)
 #      		render :status => 200, :json => {:response => "Unregistered"}
 #    	else
 #      		render :status => 400, :json => {:response => "Attempt failed"}
 #    	end
	# end

	# def get_info
	# 	trip = Trips.find_by(:id => params[:id])
	# 	render :json => {
	# 		:user_id => user.id,
	# 		:title => tournament.title,
	# 		:venue => tournament.venue,
	# 		:date => pretty_date(tournament.date),
	# 	}
	# end

	# def load_all
	# 	tournamentsArray = Tournament.order("date")
	# 	package = []
	# 	tournamentsArray.each do |tournament|
	# 		if tournament.users.include?(current_user)
	# 			registered = "true"
	# 		else
	# 			registered = "false"
	# 		end
	# 		newTournament = {
	# 		:register => registered,
	# 		:id => tournament.id,
	# 		:title => tournament.title,
	# 		:venue => tournament.venue,
	# 		:date => pretty_date(tournament.date),
	# 		:entryfee => number_to_currency(tournament.entryfee),
	# 		:spotsavailable => (tournament.maxparticipants - tournament.users.count),
	# 		:maxparticipants => tournament.maxparticipants
	# 		}
	# 		package.push(newTournament)
	# 	end
	# 	if current_user.present?
	# 		render json: package
	# 	else
	# 		render json: {
	# 			response: "Not Permitted"
	# 		}

	# 	end
	# end

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:trip_id, :user_id)
    end
end
