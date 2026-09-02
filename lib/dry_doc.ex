defmodule DryDoc do
  @moduledoc DryDoc.Reader.read("README.md", "DryDoc")

  defmacro doc_from_file(file_path, function \\ nil) do
    module = __CALLER__.module

    quote do
      from_file(unquote(file_path), %{module: unquote(module)}, unquote(function))
    end
  end

  def from_file(file_path, env, function \\ nil) do
    module = env.module |> to_string() |> String.replace_prefix("Elixir.", "")

    annotation_label =
      if function != nil and is_atom(function) do
        "#{module}." <> (function |> to_string())
      else
        module
      end

    DryDoc.Reader.read(file_path, annotation_label)
  end

  defmacro doc_from_readme(function \\ nil) do
    module = __CALLER__.module

    quote do
      from_file("README.md", %{module: unquote(module)}, unquote(function))
    end
  end

  def from_readme(env, function \\ nil) do
    from_file("README.md", env, function)
  end

  def before_closing_head_tag_hide_pages_tab(:epub), do: nil

  def before_closing_head_tag_hide_pages_tab(:html) do
    # Because we have no "extras" in the Pages section, hide this tab for clarity:
    """
    <style>
      #extras-list-tab-button { display: none; }
    </style>
    """
  end

  def before_closing_body_tag_expand_sections_list(:epub), do: nil

  def before_closing_body_tag_expand_sections_list(:html) do
    # Automatically expand the "Sections" list in the sidebar for visibility.
    # Expand during page load, and also any time the sidebar is opened (for mobile).
    """
    <script>
      function expandSections() {
        const selector = 'button[aria-controls$="-sections-list"]';
        const sectionsToggle = document.querySelector(selector);
        if (sectionsToggle && sectionsToggle.getAttribute("aria-expanded") !== "true") {
          sectionsToggle.click();
        }
      }
      function expandSectionsWhenSidebarOpens() {
        const sidebarToggle = document.querySelector('button#sidebar-menu');
        if (sidebarToggle && window.MutationObserver !== undefined) {
          new MutationObserver(function (mutationList) {
            for (const mutation of mutationList) {
              if (mutation.type === "attributes"
                && mutation.attributeName === "aria-expanded"
                && mutation.target.getAttribute("aria-epanded") === "true"
              ) {
                expandSections();
              }
            }
          }).observe(sidebarToggle, { attributes: true });
        }
      }
      addEventListener("DOMContentLoaded", function () {
        requestAnimationFrame(expandSections); // wait for full sidebar render
        requestAnimationFrame(expandSectionsWhenSidebarOpens);
      });
    </script>
    """
  end
end
