defmodule DryDoc.MixProject do
  use Mix.Project

  @name "DryDoc"
  @version "0.1.1"
  @repository "https://github.com/e2enterprises/dry_doc"

  defp description() do
    "Docs without repeating yourself."
  end

  def project do
    [
      app: :dry_doc,
      description: description(),
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
      name: @name,
      source_url: @repository,
      homepage_url: @repository
    ]
  end

  defp package() do
    [
      maintainers: ["Evan Campbell Purcer"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repository}
    ]
  end

  defp docs() do
    [
      main: DryDoc,
      before_closing_head_tag: &DryDoc.before_closing_head_tag_hide_pages_tab/1,
      before_closing_body_tag: &DryDoc.before_closing_body_tag_expand_sections_list/1
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:makeup_js, "~> 0.1.0", only: :dev, runtime: false},
      {:makeup_diff, "~> 0.1.0", only: :dev, runtime: false}
    ]
  end

  def application do
    []
  end
end
