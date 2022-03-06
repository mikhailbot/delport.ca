defmodule DelportCa.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :date, :date
    field :title, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :date, :slug])
    |> validate_required([:title, :body, :date, :slug])
    |> slug()
  end

  defp slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{slug: slug}} ->
        put_change(changeset, :slug, create_valid_slug(slug))

      _ ->
        changeset
    end
  end

  def create_valid_slug(slug) do
    slug |> String.downcase() |> String.replace(~r([^a-z-]), "") |> String.replace(~r(-{2,}), "-")
  end
end
