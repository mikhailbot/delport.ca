defmodule DelportCa.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DelportCa.Content` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        date: ~D[2022-03-02],
        title: "some title",
        slug: "some-title"
      })
      |> DelportCa.Content.create_post()

    post
  end
end
