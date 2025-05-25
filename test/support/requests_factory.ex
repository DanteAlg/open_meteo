defmodule OpenMeteo.RequestsFactory do
  def build(factory, params \\ [])

  def build(:get_forecast_success, params) do
    series = Keyword.get(params, :temperature_2m_max, [22.8, 24.4, 25.0, 24.2, 26.0, 18.7, 18.7])

    %{
      "daily" => %{
        "temperature_2m_max" => series,
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

  def build(:get_forecast_failure, _params) do
    %{
      "error" => true,
      "reason" => "Parameter 'latitude' and 'longitude' must have the same number of elements"
    }
  end
end
