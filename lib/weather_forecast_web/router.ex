defmodule WeatherForecastWeb.Router do
  use WeatherForecastWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", WeatherForecastWeb do
    pipe_through :api

    get "/cities", CityController, :index
    get "/monitored_cities", CityController, :forecast
    get "/monitored_cities/:city_id/readings", ReadingController, :index

  end
end
