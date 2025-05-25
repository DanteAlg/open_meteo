defmodule OpenMeteo.ConnCase do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case

      import OpenMeteo.RequestsFactory
    end
  end
end
