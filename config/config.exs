import Config

config :open_meteo, env: config_env()

config :open_meteo, OpenMeteo.API.WeatherApi.Builder, base: []

import_config "#{config_env()}.exs"
