defmodule WeatherForecastWeb.ReadingControllerTest do
  use WeatherForecastWeb.ConnCase

  alias WeatherForecast.Forecast
  alias WeatherForecast.Forecast.Reading

  @create_attrs %{
    city_id: 42
  }
  @update_attrs %{
    city_id: 43
  }
  @invalid_attrs %{city_id: nil}

  def fixture(:reading) do
    {:ok, reading} = Forecast.create_reading(@create_attrs)
    reading
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all readings", %{conn: conn} do
      conn = get(conn, Routes.reading_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reading" do
    test "renders reading when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reading_path(conn, :create), reading: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.reading_path(conn, :show, id))

      assert %{
               "id" => id,
               "city_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reading_path(conn, :create), reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update reading" do
    setup [:create_reading]

    test "renders reading when data is valid", %{conn: conn, reading: %Reading{id: id} = reading} do
      conn = put(conn, Routes.reading_path(conn, :update, reading), reading: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.reading_path(conn, :show, id))

      assert %{
               "id" => id,
               "city_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, reading: reading} do
      conn = put(conn, Routes.reading_path(conn, :update, reading), reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reading" do
    setup [:create_reading]

    test "deletes chosen reading", %{conn: conn, reading: reading} do
      conn = delete(conn, Routes.reading_path(conn, :delete, reading))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.reading_path(conn, :show, reading))
      end
    end
  end

  defp create_reading(_) do
    reading = fixture(:reading)
    %{reading: reading}
  end
end
