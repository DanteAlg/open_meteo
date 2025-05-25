defmodule OpenMeteo.APITest do
  use OpenMeteo.ConnCase, async: true

  alias OpenMeteo.API

  describe "max_temperature_series/2" do
    test "When is a know city should return temperature series" do
      series = [1, 2, 3, 4, 5, 6]
      response = build(:get_forecast_success, temperature_2m_max: series)

      Req.Test.stub(WeatherApiMock, fn conn ->
        assert conn.query_string ==
                 "daily=temperature_2m_max&timezone=America%2FSao_Paulo&forecast_days=6&latitude=-23.55&longitude=-46.63"

        Req.Test.json(conn, response)
      end)

      assert series == API.max_temperature_series("São Paulo")
    end

    test "When sends a valid opts param should change request" do
      response = build(:get_forecast_success)

      Req.Test.stub(WeatherApiMock, fn conn ->
        assert conn.query_string ==
                 "daily=temperature_2m_max&timezone=America%2FSao_Paulo&latitude=-23.55&longitude=-46.63&forecast_days=10"

        Req.Test.json(conn, response)
      end)

      API.max_temperature_series("São Paulo", forecast_days: 10)
    end

    test "When is a unknow city should request without lat and long data and return empty temperature series" do
      response = build(:get_forecast_failure)

      Req.Test.stub(WeatherApiMock, fn conn ->
        assert conn.query_string ==
                 "daily=temperature_2m_max&timezone=America%2FSao_Paulo&forecast_days=6"

        conn
        |> Plug.Conn.put_status(400)
        |> Req.Test.json(response)
      end)

      assert [] == API.max_temperature_series("Unknow city")
    end
  end
end
