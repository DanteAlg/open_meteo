defmodule OpenMeteo.API.WeatherApi.Builder do
  @spec base_request() :: Req.Request.t()
  def base_request do
    :open_meteo
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:base)
    |> Req.new()
  end
end
