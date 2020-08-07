defmodule WeatherForecastWeb.ReadingView do
  use WeatherForecastWeb, :view
  alias WeatherForecastWeb.ReadingView

  def render("index.json", %{readings: readings}) do
    %{data: render_many(readings, ReadingView, "reading.json")}
  end

  def render("show.json", %{reading: reading}) do
    %{data: render_one(reading, ReadingView, "reading.json")}
  end

  def render("reading.json", %{reading: reading}) do
    %{
      time: reading["dt"],
      temp: reading["temp"],
      pressure: reading["pressure"],
      humidity: reading["humidity"],
      weather: reading["weather"],
      wind_speed: reading["speed"],
      cloud_coverage: reading["clouds"],
      uvi: reading["uvi"],
      deg: reading["deg"]
    }
  end
end
