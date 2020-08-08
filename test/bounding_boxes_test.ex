alias WeatherForecast.Helpers.BoundingBox

defmodule WeatherForecast.BoundingBoxTest do

  describe "valid_lat" do
    test "Should mark as valid" do

      # given
      lat = "-23.5"

      # when
      result = BoundingBox.valid_lat(lat)

      # then
      expected_outcome = true
      assert expected_outcome = result

    end

    test "Should mark as invalid" do

      # given
      lat = "invalid"

      # when
      result = BoundingBox.valid_lat(lat)

      # then
      expected_outcome = false
      assert expected_outcome = result
    end
  end

  describe "valid_lng" do
    test "Should mark as valid" do

      # given
      lng = "-23.5"

      # when
      result = BoundingBox.valid_lng(lng)

      # then
      expected_outcome = true
      assert expected_outcome = result

    end

    test "Should mark as invalid" do

      # given
      lng = "invalid"

      # when
      result = BoundingBox.valid_lng(lng)

      # then
      expected_outcome = false
      assert expected_outcome = result
    end
  end

  describe "resolve_bounds" do
    test "Should have a bounding box" do

      # given
      top_left_lat = "-23.5"
      top_left_lng = "-46.6"
      bottom_right_lat = "-24"
      bottom_right_lng = "-45"
      # when
      result = BoundingBox.resolve_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng)

      # then
      expected_outcome =     %{
        top_left_lat: "-23.5",
        top_left_lng: "-46.6",
        bottom_right_lat: "-24",
        bottom_right_lng: "-45"
      }
      assert expected_outcome = result
    end

    test "Should rearrange to have a valid bounding box" do

      # given
      top_left_lat = "-24"
      top_left_lng = "-45"
      bottom_right_lat = "-23.5"
      bottom_right_lng = "-46.6"
      # when
      result = BoundingBox.resolve_bounds(top_left_lat, top_left_lng, bottom_right_lat, bottom_right_lng)

      # then
      expected_outcome =     %{
        top_left_lat: "-23.5",
        top_left_lng: "-46.6",
        bottom_right_lat: "-24",
        bottom_right_lng: "-45"
      }
      assert expected_outcome = result

    end


  end
end
