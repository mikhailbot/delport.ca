defmodule DelportCaWeb.PostControllerTest do
  use DelportCaWeb.ConnCase

  describe "GET /writing" do
    import DelportCa.ContentFixtures

    test "renders list of posts", %{conn: conn} do
      post = post_fixture()

      conn = get(conn, "/writing")

      assert html_response(conn, 200) =~ post.title
      assert html_response(conn, 200) =~ Date.to_string(post.date)
    end
  end
end
