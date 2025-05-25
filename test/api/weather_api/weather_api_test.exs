defmodule OpenMeteo.API.WeatherApiTest do
  use ExUnit.Case, async: true

  alias OpenMeteo.API.WeatherApi

  describe "get_forecast/1" do
    test "When success should return :ok with response body" do
      Req.Test.stub(WeatherApiMock, fn conn ->
        assert conn.request_path == "/v1/forecast"
        assert conn.query_string == "latitude=-23.4&longitude=-12.56"

        Req.Test.json(conn, get_forecast_success())
      end)

      assert {:ok, get_forecast_success()} ==
               WeatherApi.get_forecast(latitude: -23.4, longitude: -12.56)
    end

    test "When failure should return :error with req response" do
      Req.Test.stub(WeatherApiMock, fn conn ->
        conn
        |> Plug.Conn.put_status(400)
        |> Req.Test.json(get_forecast_params_failure())
      end)

      assert {:error, %Req.Response{body: body}} = WeatherApi.get_forecast([])
      assert body == get_forecast_params_failure()
    end
  end

  def get_forecast_success do
    %{
      "daily" => %{
        "temperature_2m_max" => [22.8, 24.4, 25.0, 24.2, 26.0, 18.7, 18.7],
        "time" => [
          "2025-05-24",
          "2025-05-25",
          "2025-05-26",
          "2025-05-27",
          "2025-05-28",
          "2025-05-29",
          "2025-05-30"
        ]
      },
      "daily_units" => %{"temperature_2m_max" => "°C", "time" => "iso8601"},
      "elevation" => 737.0,
      "generationtime_ms" => 0.018596649169921875,
      "latitude" => -23.5,
      "longitude" => -46.5,
      "timezone" => "America/Sao_Paulo",
      "timezone_abbreviation" => "GMT-3",
      "utc_offset_seconds" => -10_800
    }
  end

  def get_forecast_params_failure do
    %{
      "error" => true,
      "reason" => "Parameter 'latitude' and 'longitude' must have the same number of elements"
    }
  end
end
