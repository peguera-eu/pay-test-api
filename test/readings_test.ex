alias WeatherForecast.Readings

defmodule WeatherForecast.ReadingsTest do

  describe "get_most_recent" do
    test "Should get the most recent reading for a given city ID" do

      # given
      city_id = "3992619"

      # when
      result = Readings.get_most_recent(city_id)

      # then
      expected_outcome = 1
      assert expected_outcome = Enum.count(result)

    end
  end

  describe "get_from_range" do
    test "Should get the readings in range for a given city ID" do

      # given
      city_id = "3992619"
      from = 1490572800
      to = 1490745600
      # when
      result = Readings.get_from_range(city_id, from, to)

      # then
      expected_outcome = 2
      assert expected_outcome = Enum.count(result)

    end
  end

end
