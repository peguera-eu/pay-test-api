defmodule WeatherForecastWeb.Router do
  use WeatherForecastWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", WeatherForecastWeb do
    pipe_through :api

    # Get list of cities
    # Get list of cities with forecasts available
    # Get most recent reading for a city
    # Get readings in a range for a city
    get "/cities", CityController, :index
    get "/monitored_cities", CityController, :forecast
    get "monitored_cities/:city_id/readings", ReadingController, :index

  end
end
