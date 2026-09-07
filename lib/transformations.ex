defmodule DryDoc.Transformations do
  @doc DryDoc.Reader.read(
         "README.md",
         "DryDoc.Transformations.github_admonitions_to_ex_doc_syntax"
       )

  def github_admonitions_to_ex_doc_syntax(markdown) do
    markdown
    |> String.replace(
      ~r/\n> \[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\n>/m,
      "\n> #### \\1 {: .\\1}\n>"
    )
    |> String.replace("> #### NOTE {: .NOTE}", "> #### Note {: .info}")
    |> String.replace("> #### TIP {: .TIP}", "> #### Tip {: .tip}")
    |> String.replace("> #### IMPORTANT {: .IMPORTANT}", "> #### Important {: .info}")
    |> String.replace("> #### WARNING {: .WARNING}", "> #### Warning {: .warning}")
    |> String.replace("> #### CAUTION {: .CAUTION}", "> #### Caution {: .error}")
  end
end
