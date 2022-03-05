defmodule DelportCaWeb.PostController do
  use DelportCaWeb, :controller
  alias DelportCa.Content

  def index(conn, _params) do
    posts = Content.ordered_posts()

    render(conn, "index.html", posts: posts)
  end
end
