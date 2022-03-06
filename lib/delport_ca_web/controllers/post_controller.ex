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

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    case Content.create_post(params) do
      {:ok, post} ->
        conn
        |> redirect(to: Routes.post_path(conn, :show, post.date.year, post.slug))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
