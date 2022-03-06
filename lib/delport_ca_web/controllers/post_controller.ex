defmodule DelportCaWeb.PostController do
  use DelportCaWeb, :controller
  alias DelportCa.Content

  def index(conn, _params) do
    posts = Content.ordered_posts()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"slug" => slug} = _params) do
    post = Content.get_post_by_slug!(slug)

    render(conn, "show.html", post: post)
  end
end
