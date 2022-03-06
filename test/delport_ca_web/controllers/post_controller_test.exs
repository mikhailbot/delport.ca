defmodule DelportCaWeb.PostControllerTest do
  use DelportCaWeb.ConnCase

  import DelportCa.ContentFixtures

  test "renders list of posts", %{conn: conn} do
    post = post_fixture()

    conn = get(conn, "/writing")

    assert html_response(conn, 200) =~ post.title
    assert html_response(conn, 200) =~ Date.to_string(post.date) |> String.replace("-", ".")
  end

  test "renders individual post", %{conn: conn} do
    post = post_fixture()
    post_url = "/#{post.date.year}/#{post.slug}"

    conn = get(conn, post_url)

    assert html_response(conn, 200) =~ post.title
    assert html_response(conn, 200) =~ Date.to_string(post.date) |> String.replace("-", ".")
  end
end
