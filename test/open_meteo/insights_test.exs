defmodule OpenMeteo.InsightsTest do
  use OpenMeteo.ConnCase, async: true

  alias OpenMeteo.Insights

  describe "avarage_max_temperature/2" do
    test "When is a know city should return average temperature" do
      series = [1, 2, 3, 4, 5, 6]
      response = build(:get_forecast_success, temperature_2m_max: series)

      Req.Test.stub(WeatherApiMock, fn conn ->
        Req.Test.json(conn, response)
      end)

      assert 3.5 == Insights.avarage_max_temperature("São Paulo")
    end

    test "When is a unknow city should return 0" do
      response = build(:get_forecast_failure)

      Req.Test.stub(WeatherApiMock, fn conn ->
        conn
        |> Plug.Conn.put_status(400)
        |> Req.Test.json(response)
      end)

      assert 0.0 == Insights.avarage_max_temperature("Unknow city")
    end
  end
end
