defmodule WeatherForecast.Helpers.BoundingBox do

  def resolve_bounds(p1_lat, p1_lng, p2_lat, p2_lng) do
    {parsed_p1_lat, _} = Float.parse(p1_lat)
    {parsed_p1_lng, _} = Float.parse(p1_lng)
    {parsed_p2_lat, _} = Float.parse(p2_lat)
    {parsed_p2_lng, _} = Float.parse(p2_lng)

    top_left_lat = Enum.max [parsed_p1_lat, parsed_p2_lat]
    top_left_lng = Enum.min [parsed_p1_lng, parsed_p2_lng]
    bottom_right_lat = Enum.min [parsed_p1_lat, parsed_p2_lat]
    bottom_right_lng = Enum.max [parsed_p1_lng, parsed_p2_lng]

    %{
      top_left_lat: top_left_lat,
      top_left_lng: top_left_lng,
      bottom_right_lat: bottom_right_lat,
      bottom_right_lng: bottom_right_lng
    }
  end

end
