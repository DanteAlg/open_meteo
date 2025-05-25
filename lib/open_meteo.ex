defmodule OpenMeteo do
  alias OpenMeteo.Insights

  def call do
    spawn_monitor(__MODULE__, :average_temperature, ["São Paulo"])
    spawn_monitor(__MODULE__, :average_temperature, ["Belo Horizonte"])
    spawn_monitor(__MODULE__, :average_temperature, ["Curitiba"])
  end

  @spec average_temperature(binary()) :: :ok
  def average_temperature(city) do
    temp = Insights.avarage_max_temperature(city)
    IO.puts("#{city}: #{temp}C°")
  end
end
