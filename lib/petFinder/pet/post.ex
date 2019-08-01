defmodule PetFinder.Pet.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :status, :string
    field :animal_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:description, :status, :animal_id])
    |> validate_required([:description, :status])
  end
end
