defmodule PetFinder.Pet.Image do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :image, PetFinder.ImageUploader.Type
    belongs_to :animal, PetFinder.Pet.Animal

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    IO.inspect(attrs, label: "ooooo")
    image
    |> cast(attrs, [:image])
    |> cast_attachments(attrs, [:image])
  end
end
