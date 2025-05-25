# OpenMeteo

* Elixir 1.18.4-otp-27
* Erlang 27.0

Test using https://open-meteo.com/ public api

Executing to São Paulo, Belo Horizonte and Curitiba samples using `iex -S mix`:

```elixir
iex(1)> OpenMeteo.call()
Belo Horizonte: 25.5C°
São Paulo: 22.7C°
Curitiba: 17.5C°
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `open_meteo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_meteo, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/open_meteo>.

