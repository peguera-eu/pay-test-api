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
    %{id: reading.id,
      city_id: reading.city_id}
  end
end
