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
    case Timex.parse(from, "{YYYY}-{0M}-{D}") do
      {:ok, parsed_from} ->
        from_timestamp = Timex.to_unix(parsed_from)
        case Timex.parse(to, "{YYYY}-{0M}-{D}") do
          {:ok, parsed_to} ->
            to_timestamp = Timex.to_unix(parsed_to)
            case Integer.parse(city_id) do
              {integer_city_id, _} ->
                readings = Readings.get_from_range(integer_city_id, from_timestamp, to_timestamp)
                case readings do
                  {:error, reason} ->
                    {:error, :internal_server_error, reason}
                  [_ | _] = data ->
                    render(conn, "index.json", readings: data)
                  [] ->
                    render(conn, "index.json", reading: [])
                end
              :error ->
                {:error, "Invalid city ID"}
            end
          {:error, reason} ->
            {:error, :unprocessable_entity, reason}
        end
      {:error, reason} ->
        {:error, :unprocessable_entity, reason}
    end
  end


  def fetch_readings(%{path_params: %{ "city_id" => city_id }} = conn) do
    case Integer.parse(city_id) do
      {integer_city_id, _} ->
        reading = Readings.get_most_recent(integer_city_id)
        case reading do
          {:error, reason} ->
            {:error, :internal_server_error, reason}
          [_ | _] = data ->
            render(conn, "reading.json", reading: data)
          [] ->
            render(conn, "reading.json", reading: [])
        end
      :error ->
        {:error, :unprocessable_entity, "Invalid city ID"}
    end
  end

end
