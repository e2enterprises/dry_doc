defmodule DryDoc.Reader do
  def read(file_path, annotation_label \\ nil) do
    [_ | sections] =
      File.read!(file_path)
      |> String.split([
        "<!-- #{annotation_label} -->",
        "<!-- @doc #{annotation_label} -->",
        "<!-- @moduledoc #{annotation_label} -->"
      ])

    for section <- sections, into: "" do
      [text | _] =
        String.split(section, [
          "<!-- #{annotation_label} -->",
          "<!-- @doc #{annotation_label} -->",
          "<!-- @moduledoc #{annotation_label} -->",
          "<!-- /#{annotation_label} -->",
          "<!-- /@doc #{annotation_label} -->",
          "<!-- /@moduledoc #{annotation_label} -->"
        ])

      text
    end
  end
end
