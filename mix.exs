defmodule Vips.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :vips,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),

     # Hex
     description: description(),
     package: package(),

     #Docs
     name: "VIPS",
     docs: [source_ref: "v#{@version}",
            main: "Vips",
            canonical: "http://hexdocs.pm/vips",
            source_url: "https://github.com/schultzer/vips",
            description: "VIPS command line wrapper."]]
  end

  def application do
    [applications: [:crypto, :logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    """
    VIPS command line wrapper.
    """
  end

  defp package do
    [name: :vips,
     maintainers: ["Benjamin Schultzer"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/schultzer/vips",
              "Docs" => "https://hexdocs.pm/vips"},
     files: ~w(lib) ++
            ~w(mix.exs README.md LICENSE mix.exs)]
  end
end
