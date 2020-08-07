defmodule WeatherForecastWeb.ReadingController do
  use WeatherForecastWeb, :controller

  action_fallback WeatherForecastWeb.FallbackController

  def index(conn, _params) do
    conn
    |> fetch_query_params
    |> fetch_readings()
  end

  def fetch_readings(%{path_params: %{ "city_id" => city_id }} = conn) do

  end

  def fetch_readings(%{query_params: %{ "from" => from, "to" => to },path_params: %{ "city_id" => city_id }} = conn) do

  end
end
