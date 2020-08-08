defmodule WeatherForecastWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use WeatherForecastWeb, :controller

  def call(conn, {:error, :unprocessable_entity, reason}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(WeatherForecastWeb.ErrorView)
    |> render(:"422", %{reason: reason})
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(WeatherForecastWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :internal_server_error, reason}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(WeatherForecastWeb.ErrorView)
    |> render(:"500", %{reason: reason})
  end

end
