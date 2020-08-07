defmodule WeatherForecastWeb.Router do
  use WeatherForecastWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WeatherForecastWeb do
    pipe_through :api
  end
end
