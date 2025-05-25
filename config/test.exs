import Config

config :open_meteo, OpenMeteo.API.WeatherApi.Builder,
  base: [plug: {Req.Test, WeatherApiMock}]
