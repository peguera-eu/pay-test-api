alias WeatherForecast.Cities

defmodule WeatherForecast.CitiesTest do

  describe "get_with_readings" do
    test "Should get the two cities that have readings" do

      # when
      result = Cities.get_with_readings()

      # then
      expected_outcome = 2
      assert expected_outcome = Enum.count(result)

    end
  end

  describe "get_from_bounds" do
    test "Should get all cities within bounds" do

      # when
      result = Cities.get_from_bounds("89","-179","-89","179")

      # then
      expected_outcome = 46
      assert expected_outcome = Enum.count(result)

    end
  end

end
