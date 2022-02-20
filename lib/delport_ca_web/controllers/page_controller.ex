defmodule DelportCaWeb.PageController do
  use DelportCaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
