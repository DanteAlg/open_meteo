defmodule OpenMeteo.API do
  alias OpenMeteo.API.WeatherApi

  @default_params [timezone: "America/Sao_Paulo", forecast_days: 6]

  @coordinates %{
    "São Paulo" => {-23.55, -46.63},
    "Belo Horizonte" => {-19.92, -43.94},
    "Curitiba" => {-25.43, -49.27}
  }

  @spec max_temperature_series(binary(), keyword()) :: [float()]
  @spec max_temperature_series(binary()) :: [float()]
  def max_temperature_series(city, opts \\ []) do
    @default_params
    |> fetch_and_merge_coordinates(city)
    |> Keyword.merge(opts)
    |> Keyword.put(:daily, "temperature_2m_max")
    |> WeatherApi.get_forecast()
    |> handle_forecast_response()
  end

  defp fetch_and_merge_coordinates(params, city) do
    case Map.get(@coordinates, city) do
      {latitude, longitude} -> params ++ [latitude: latitude, longitude: longitude]
      nil -> params
    end
  end

  defp handle_forecast_response({:ok, %{"daily" => %{"temperature_2m_max" => series}}}),
    do: series

  defp handle_forecast_response(_response), do: []
end
