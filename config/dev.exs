import Config

config :open_meteo, OpenMeteo.API.WeatherApi.Builder,
  base: [base_url: "https://api.open-meteo.com/"]
