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

  test "saving a new post", %{conn: conn} do
    valid_attrs = %{
      body: "some body",
      date: ~D[2022-03-02],
      title: "some title",
      slug: "some-title"
    }

    conn = post(conn, Routes.cp_post_path(conn, :create), valid_attrs)

    assert redirected_to(conn) == "/#{valid_attrs.date.year}/#{valid_attrs.slug}"
  end

  test "create a new post", %{conn: conn} do
    conn = get(conn, Routes.cp_post_path(conn, :new))

    assert html_response(conn, 200) =~ "Save Post"
  end
end
