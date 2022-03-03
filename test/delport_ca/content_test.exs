defmodule DelportCa.ContentTest do
  use DelportCa.DataCase

  alias DelportCa.Content

  describe "posts" do
    alias DelportCa.Content.Post

    import DelportCa.ContentFixtures

    @invalid_attrs %{body: nil, date: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Content.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{body: "some body", date: ~D[2022-03-02], title: "some title"}

      assert {:ok, %Post{} = post} = Content.create_post(valid_attrs)
      assert post.body == "some body"
      assert post.date == ~D[2022-03-02]
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{body: "some updated body", date: ~D[2022-03-03], title: "some updated title"}

      assert {:ok, %Post{} = post} = Content.update_post(post, update_attrs)
      assert post.body == "some updated body"
      assert post.date == ~D[2022-03-03]
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_attrs)
      assert post == Content.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Content.change_post(post)
    end
  end
end
