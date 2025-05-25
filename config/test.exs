import Config

config :open_meteo, OpenMeteo.API.WeatherApi.Builder,
  base: [base_url: "/", plug: {Req.Test, WeatherApiMock}]
