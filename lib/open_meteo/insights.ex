defmodule OpenMeteo.Insights do
  alias OpenMeteo.API

  @spec avarage_max_temperature(binary()) :: float()
  @spec avarage_max_temperature(binary(), keyword()) :: float()
  def avarage_max_temperature(city, opts \\ []) do
    city
    |> API.max_temperature_series(opts)
    |> average()
    |> Float.round(1)
  end

  defp average([]), do: 0.0

  defp average(list), do: Enum.sum(list) / Enum.count(list)
end
