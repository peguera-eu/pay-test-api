defmodule WeatherForecastWeb.CityController do
  use WeatherForecastWeb, :controller

  alias WeatherForecast.Cities
  alias WeatherForecast.Helpers.BoundingBox
  action_fallback WeatherForecastWeb.FallbackController

  def index(conn, _params) do
    conn
    |> fetch_query_params
    |> fetch_cities
  end

  def fetch_cities(%{query_params: %{ "top_left_lat" => top_left_lat, "top_left_lng" => top_left_lng, "bottom_right_lat" => bottom_right_lat, "bottom_right_lng" => bottom_right_lng}} = conn) do
    if(BoundingBox.valid_lat(top_left_lat) && BoundingBox.valid_lng(top_left_lng) && BoundingBox.valid_lat(bottom_right_lat) && BoundingBox.valid_lng(bottom_right_lng)) do
      cities = Cities.get_from_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng)
      case cities do
        {:error, reason} ->
          {:error, :internal_server_error, reason}
        [_ | _] = data ->
          render(conn, "index.json", cities: data)
        [] ->
          render(conn, "index.json", cities: [])
      end
    else
      {:error, :unprocessable_entity, "One or more coordinates are invalid"}
    end

  end

  def fetch_cities(conn) do
    cities = Cities.get_all()
    case cities do
      {:error, reason} ->
        {:error, :internal_server_error, reason}
      [_ | _] = data ->
        render(conn, "index.json", cities: data)
      [] ->
        render(conn, "index.json", cities: [])
    end
  end

  def forecast(conn, _params) do
    cities = Cities.get_with_readings()
    case cities do
      {:error, reason} ->
        {:error, :internal_server_error, reason}
      [_ | _] = data ->
        render(conn, "index.json", cities: data)
      [] ->
        render(conn, "index.json", cities: [])
    end
  end
end
