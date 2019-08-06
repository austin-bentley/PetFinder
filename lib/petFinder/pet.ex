defmodule PetFinder.Pet do
  @moduledoc """
  The Pet context.
  """

  import Ecto.Query, warn: false
  alias PetFinder.Repo

  alias PetFinder.Pet.Animal
  alias PetFinder.Pet.Post

  @doc """
  Returns the list of animals.

  ## Examples

      iex> list_animals()
      [%Animal{}, ...]

  """
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
    |> Repo.all()
  end

  def get_recently_found_animals!() do
    Post
    |> where([p], p.status == "Found")
    |> order_by(desc: :updated_at)
    |> limit(3)
    |> Repo.all()
  end

  def get_posts_near_user(user_id) do
    one = get_zip_codes(user_id)
    |> query_nearby_zip_codes()
    |> get_posts_by_animal()
    IO.inspect(one, label: "RRRRRRRRRRRRRR")
    one
  end

  defp query_nearby_zip_codes(zip_list) do
    Animal
      |> where([a], a.location in ^zip_list)
      |> Repo.all()
  end

  def get_posts_by_animal(_animals) do
    Animal
    |> Ecto.assoc(:id)
  end

  defp get_zip_codes(user_id) do
    get_animal!(user_id)
    |> Map.get(:location, "")
    |> nearby_zips_request()
    |> format_zips_into_list()
  end

  defp nearby_zips_request(zip) do
    case HTTPoison.get("https://www.zipcodeapi.com/rest/xViDTqMu89M34fHGfguSlO0VPpVkXEulf9uZ1yMvBbsOR4d8h0HfJCiv5m8XUyTd/radius.json/#{zip}/4/mile") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.inspect(label: "ERROR: No zip codes found!")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason, label: "ERROR: ")
    end
  end

  defp format_zips_into_list(request_body) do
    request_body["zip_codes"]
    |> Enum.map(& &1["zip_code"])
  end

  @doc """
  Gets a single animal.

  Raises `Ecto.NoResultsError` if the Animal does not exist.

  ## Examples

      iex> get_animal!(123)
      %Animal{}

      iex> get_animal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_animal!(id), do: Repo.get!(Animal, id)

  @doc """
  Creates a animal.

  ## Examples

      iex> create_animal(%{field: value})
      {:ok, %Animal{}}

      iex> create_animal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_animal(attrs \\ %{}) do
    %Animal{}
    |> Animal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a animal.

  ## Examples

      iex> update_animal(animal, %{field: new_value})
      {:ok, %Animal{}}

      iex> update_animal(animal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_animal(%Animal{} = animal, attrs) do
    IO.inspect(attrs, label: ">>>")
    animal
    |> Animal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Animal.

  ## Examples

      iex> delete_animal(animal)
      {:ok, %Animal{}}

      iex> delete_animal(animal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_animal(%Animal{} = animal) do
    Repo.delete(animal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking animal changes.

  ## Examples

      iex> change_animal(animal)
      %Ecto.Changeset{source: %Animal{}}

  """
  def change_animal(%Animal{} = animal) do
    Animal.changeset(animal, %{})
  end

  alias PetFinder.Pet.Post

  def get_animal_posts(animal_id) do
    animal_id = String.to_integer(animal_id)
    query = from p in "posts", where: p.animal_id == ^animal_id, select: [:description, :status, :id], order_by: [:id]
    Repo.all(query)
  end

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
