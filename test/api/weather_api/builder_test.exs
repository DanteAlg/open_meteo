defmodule OpenMeteo.API.WeatherApi.BuilderTest do
  use ExUnit.Case

  alias OpenMeteo.API.WeatherApi.Builder

  describe "base_request/1" do
    test "Should return a req request" do
      assert %Req.Request{} = Builder.base_request()
    end
  end
end
