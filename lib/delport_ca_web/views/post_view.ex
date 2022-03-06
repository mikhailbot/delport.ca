defmodule DelportCaWeb.PostView do
  use DelportCaWeb, :view

  def formatted_date(date) do
    date
    |> Date.to_string()
    |> String.replace("-", ".")
  end
end
