defmodule WeatherForecastWeb.ReadingController do
  use WeatherForecastWeb, :controller
  use Timex

  alias WeatherForecast.Readings
  action_fallback WeatherForecastWeb.FallbackController

  def index(conn, _params) do
    conn
    |> fetch_query_params
    |> fetch_readings()
  end


  def fetch_readings(%{query_params: %{ "from" => from, "to" => to },path_params: %{ "city_id" => city_id }} = conn) do
    {:ok, parsed_from} = Timex.parse(from, "{YYYY}-{0M}-{D}")
    from_timestamp = Timex.to_unix(parsed_from)
    {:ok, parsed_to} = Timex.parse(to, "{YYYY}-{0M}-{D}")
    to_timestamp = Timex.to_unix(parsed_to)
    {integer_city_id, _} = Integer.parse(city_id)

    readings = Readings.get_from_range(integer_city_id, from_timestamp, to_timestamp)
    render(conn, "index.json", readings: readings)
  end

  def fetch_readings(%{path_params: %{ "city_id" => city_id }} = conn) do
    {integer_city_id, _} = Integer.parse(city_id)
    reading = Readings.get_most_recent(integer_city_id)
    render(conn, "reading.json", reading: reading)
  end

end
