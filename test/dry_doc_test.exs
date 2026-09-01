defmodule DryDocGlobalCSSTest do
  use ExUnit.Case
  doctest DryDoc.GlobalCSS

  test "greets the world" do
    {:ok, css, []} = DryDoc.GlobalCSS.transform("style", [], "hello world", __ENV__)
    assert css == "hello world"
  end
end

defmodule DryDocScopedCSSTest do
  use ExUnit.Case
  doctest DryDoc.ScopedCSS

  test "greets the world" do
    {:ok, css, []} = DryDoc.ScopedCSS.transform("style", [], "hello world", __ENV__)
    assert css |> String.starts_with?("@scope")
    assert css |> String.contains?("{ hello world }")
  end
end
