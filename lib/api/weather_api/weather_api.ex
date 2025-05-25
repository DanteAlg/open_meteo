defmodule OpenMeteo.API.WeatherApi do
  alias OpenMeteo.API.WeatherApi.Builder

  @spec get_forecast(keyword()) :: {:ok, map()} | {:error, Req.Response.t()}
  def get_forecast(params) do
    Builder.base_request()
    |> Req.get!(url: "v1/forecast", params: params)
    |> case do
      %{status: 200, body: response_body} ->
        {:ok, response_body}

      response ->
        {:error, response}
    end
  end
end
