defmodule WeatherForecastWeb.CityController do
  use WeatherForecastWeb, :controller

  alias WeatherForecast.Cities
  action_fallback WeatherForecastWeb.FallbackController

  def index(conn, _params) do
    query = conn
    |> fetch_query_params
    fetch_cities(query)
  end

  def fetch_cities(%{query_params: %{ "top_left_lat" => top_left_lat, "top_left_lng" => top_left_lng, "bottom_right_lat" => bottom_right_lat, "bottom_right_lng" => bottom_right_lng}} = conn) do
    cities = Cities.get_from_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng)
    render(conn, "index.json", cities: cities)
  end

  def fetch_cities(conn) do
    cities = Cities.get_all()
    render(conn, "index.json", cities: cities)
  end

  def forecast(conn, _params) do
    cities = Cities.get_with_readings()
    render(conn, "index.json", cities: cities)
  end
end
