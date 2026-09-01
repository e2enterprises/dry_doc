defmodule DryDoc do
  defmacro from(file_path) do
    module = __ENV__.module
    text = File.read!(file_path)

    for section <- text |> String.split("<!-- #{module}:start -->"), into: "" do
      section |> String.split("<!-- #{module}:stop -->") |> Enum.fetch!(1)
    end
  end
end
