defmodule WeatherForecastWeb.CityControllerTest do
  use WeatherForecastWeb.ConnCase

  alias WeatherForecast.Locations
  alias WeatherForecast.Locations.City

  @create_attrs %{
    name: "some name",
    other: "some other"
  }
  @update_attrs %{
    name: "some updated name",
    other: "some updated other"
  }
  @invalid_attrs %{name: nil, other: nil}

  def fixture(:city) do
    {:ok, city} = Locations.create_city(@create_attrs)
    city
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cities", %{conn: conn} do
      conn = get(conn, Routes.city_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create city" do
    test "renders city when data is valid", %{conn: conn} do
      conn = post(conn, Routes.city_path(conn, :create), city: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.city_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "other" => "some other"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.city_path(conn, :create), city: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update city" do
    setup [:create_city]

    test "renders city when data is valid", %{conn: conn, city: %City{id: id} = city} do
      conn = put(conn, Routes.city_path(conn, :update, city), city: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.city_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "other" => "some updated other"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, city: city} do
      conn = put(conn, Routes.city_path(conn, :update, city), city: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete city" do
    setup [:create_city]

    test "deletes chosen city", %{conn: conn, city: city} do
      conn = delete(conn, Routes.city_path(conn, :delete, city))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.city_path(conn, :show, city))
      end
    end
  end

  defp create_city(_) do
    city = fixture(:city)
    %{city: city}
  end
end
