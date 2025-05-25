defmodule OpenMeteo.API.WeatherApiTest do
  use OpenMeteo.ConnCase, async: true

  alias OpenMeteo.API.WeatherApi

  describe "get_forecast/1" do
    test "When success should return :ok with response body" do
      response = build(:get_forecast_success)

      Req.Test.stub(WeatherApiMock, fn conn ->
        assert conn.request_path == "/v1/forecast"
        assert conn.query_string == "latitude=-23.4&longitude=-12.56"

        Req.Test.json(conn, response)
      end)

      assert {:ok, response} ==
               WeatherApi.get_forecast(latitude: -23.4, longitude: -12.56)
    end

    test "When failure should return :error with req response" do
      response = build(:get_forecast_failure)

      Req.Test.stub(WeatherApiMock, fn conn ->
        conn
        |> Plug.Conn.put_status(400)
        |> Req.Test.json(response)
      end)

      assert {:error, %Req.Response{body: body}} = WeatherApi.get_forecast([])
      assert body == response
    end
  end
end
