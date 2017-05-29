defmodule Evrythng.ThngPush.Mixfile do
  use Mix.Project

  def project do
    [app: :thngpush,
     version: "0.17.140",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Evrythng.ThngPush.Application, []}]
  end

  defp deps do
    [{:emqttc, path: "../emqttc"},
     {:poison, "~> 3.0"},
     {:credo, "~> 0.5", only: [:dev, :test]},
     {:excheck, "~> 0.5.3", only: :test},
     {:triq, github: "triqng/triq", only: :test}]
  end
end
