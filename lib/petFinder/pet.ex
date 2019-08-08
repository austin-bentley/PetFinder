defmodule PetFinder.Pet do

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias PetFinder.Repo
  alias PetFinder.Pet.Animal
  alias PetFinder.Pet.Post
  alias PetFinder.Pet.Image


  def list_animals do
    Repo.all(Animal)
  end

  def get_user_animals!(id) do
    id = String.to_integer(id)
    query = from a in "animals", where: a.user_id == ^id, select: [:id, :species, :color], order_by: [:id]
    Repo.all(query)
  end

  def get_recently_lost_animals!() do
    Post
    |> where([p], p.status == "Lost")
    |> order_by(desc: :updated_at)
    |> limit(3)
    |> join(:inner, [p], i in Image, on: p.animal_id == i.animal_id)
    |> select([p,i], %{description: p.description, animal_id: p.animal_id, image: i.image})
    |> Repo.all()
  end

  def get_recently_found_animals!() do
    Post
    |> where([p], p.status == "Found")
    |> order_by(desc: :updated_at)
    |> limit(3)
    |> join(:inner, [p], i in Image, on: p.animal_id == i.animal_id)
    |> select([p,i], %{description: p.description, animal_id: p.animal_id, image: i.image})
    |> Repo.all()
  end

  def get_images_by_animal(id) do
    Image
    |> where([i], i.animal_id == ^id)
    |> Repo.all()
  end

  def get_animal!(id), do: Repo.get!(Animal, id)

  def create_animal(attrs \\ %{}) do
    %Animal{}
    |> Animal.changeset(attrs)
    |> Changeset.cast_assoc(:images, with: &PetFinder.Pet.Image.changeset/2)
    |> Repo.insert()
  end

  def update_animal(%Animal{} = animal, attrs) do
    animal
    |> Animal.changeset(attrs)
    |> Repo.update()
  end

  def delete_animal(%Animal{} = animal) do
    Repo.delete(animal)
  end

  def change_animal(%Animal{} = animal) do
    Animal.changeset(animal, %{})
  end

  def get_animal_posts(animal_id) do
    animal_id = String.to_integer(animal_id)
    query = from p in "posts", where: p.animal_id == ^animal_id, select: [:description, :status, :id], order_by: [:id]
    Repo.all(query)
  end

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
