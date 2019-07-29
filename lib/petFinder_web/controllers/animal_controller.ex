defmodule PetFinderWeb.AnimalController do
  use PetFinderWeb, :controller

  alias PetFinder.Pet
  alias PetFinder.Pet.Animal

  # def index(conn, _params) do
  #   animals = Pet.list_animals()
  #   render(conn, "index.html", animals: animals)
  # end

  def new(conn, _params) do
    changeset = Pet.change_animal(%Animal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"animal" => animal_params}) do
    case Pet.create_animal(animal_params) do
      {:ok, animal} ->
        conn
        |> put_flash(:info, "Animal created successfully.")
        |> redirect(to: Routes.animal_path(conn, :show, animal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   animal = Pet.get_animal!(id)
  #   render(conn, "show.html", animal: animal)
  # end

  # def edit(conn, %{"id" => id}) do
  #   animal = Pet.get_animal!(id)
  #   changeset = Pet.change_animal(animal)
  #   render(conn, "edit.html", animal: animal, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "animal" => animal_params}) do
  #   animal = Pet.get_animal!(id)

  #   case Pet.update_animal(animal, animal_params) do
  #     {:ok, animal} ->
  #       conn
  #       |> put_flash(:info, "Animal updated successfully.")
  #       |> redirect(to: Routes.animal_path(conn, :show, animal))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", animal: animal, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   animal = Pet.get_animal!(id)
  #   {:ok, _animal} = Pet.delete_animal(animal)

  #   conn
  #   |> put_flash(:info, "Animal deleted successfully.")
  #   |> redirect(to: Routes.animal_path(conn, :index))
  # end
end
