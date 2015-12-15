require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  setup do
    @trip = trips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post :create, trip: { city1: @trip.city1, city2: @trip.city2, country1: @trip.country1, country2: @trip.country2, date: @trip.date, description: @trip.description, destination: @trip.destination, lat1: @trip.lat1, lat2: @trip.lat2, list_stops: @trip.list_stops, lng1: @trip.lng1, lng2: @trip.lng2, origin: @trip.origin, price: @trip.price, seat: @trip.seat, time: @trip.time, user_id: @trip.user_id }
    end

    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should show trip" do
    get :show, id: @trip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip
    assert_response :success
  end

  test "should update trip" do
    patch :update, id: @trip, trip: { city1: @trip.city1, city2: @trip.city2, country1: @trip.country1, country2: @trip.country2, date: @trip.date, description: @trip.description, destination: @trip.destination, lat1: @trip.lat1, lat2: @trip.lat2, list_stops: @trip.list_stops, lng1: @trip.lng1, lng2: @trip.lng2, origin: @trip.origin, price: @trip.price, seat: @trip.seat, time: @trip.time, user_id: @trip.user_id }
    assert_redirected_to trip_path(assigns(:trip))
  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete :destroy, id: @trip
    end

    assert_redirected_to trips_path
  end
end
