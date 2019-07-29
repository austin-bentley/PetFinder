defmodule PetFinder.Pet.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animals" do
    field :color, {:array, :string}
    field :location, :string
    field :species, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(animal, attrs) do
    animal
    |> cast(attrs, [:species, :color, :location])
    |> validate_required([:species, :color, :location])
  end
end
