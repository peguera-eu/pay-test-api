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
    %{id: city["id"],
      name: city["name"],
      country: city["country"],
      location: %{
        lat: city["coord"]["lat"],
        lng: city["coord"]["lon"]
      },
      geoname: city["geoname"],
      stat: city["stat"],
      stations: city["stations"],
      zoom: city["zoom"]
    }
  end
end
