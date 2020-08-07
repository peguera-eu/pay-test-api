defmodule WeatherForecastWeb.CityView do
  use WeatherForecastWeb, :view
  alias WeatherForecastWeb.CityView

  def render("index.json", %{cities: cities}) do
    %{data: render_many(cities, CityView, "city.json")}
  end

  def render("show.json", %{city: city}) do
    %{data: render_one(city, CityView, "city.json")}
  end

  def render("city.json", %{city: city}) do
    location = city["coord"]
    %{id: city["id"],
      name: city["name"],
      code: city["code"],
      location: %{
        lat: location["lat"],
        lng: location["lon"]
      }
    }
  end
end
