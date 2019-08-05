defmodule PetFinderWeb.Helpers.Pet do
  alias PetFinder.Repo
  alias PetFinder.Pet.Animal

  import Ecto.Query, warn: false

  def get_user_id_by_animal_id(animal_id) do
    Animal
    |> where([a], a.id == ^animal_id)
    |> select([a], a.user_id)
    |> Repo.all()
    |> List.first()
  end
end
