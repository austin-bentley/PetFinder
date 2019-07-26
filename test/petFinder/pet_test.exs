defmodule PetFinder.PetTest do
  use PetFinder.DataCase

  alias PetFinder.Pet

  describe "animals" do
    alias PetFinder.Pet.Animal

    @valid_attrs %{color: [], location: 42, species: "some species"}
    @update_attrs %{color: [], location: 43, species: "some updated species"}
    @invalid_attrs %{color: nil, location: nil, species: nil}

    def animal_fixture(attrs \\ %{}) do
      {:ok, animal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pet.create_animal()

      animal
    end

    test "list_animals/0 returns all animals" do
      animal = animal_fixture()
      assert Pet.list_animals() == [animal]
    end

    test "get_animal!/1 returns the animal with given id" do
      animal = animal_fixture()
      assert Pet.get_animal!(animal.id) == animal
    end

    test "create_animal/1 with valid data creates a animal" do
      assert {:ok, %Animal{} = animal} = Pet.create_animal(@valid_attrs)
      assert animal.color == []
      assert animal.location == 42
      assert animal.species == "some species"
    end

    test "create_animal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pet.create_animal(@invalid_attrs)
    end

    test "update_animal/2 with valid data updates the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{} = animal} = Pet.update_animal(animal, @update_attrs)
      assert animal.color == []
      assert animal.location == 43
      assert animal.species == "some updated species"
    end

    test "update_animal/2 with invalid data returns error changeset" do
      animal = animal_fixture()
      assert {:error, %Ecto.Changeset{}} = Pet.update_animal(animal, @invalid_attrs)
      assert animal == Pet.get_animal!(animal.id)
    end

    test "delete_animal/1 deletes the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{}} = Pet.delete_animal(animal)
      assert_raise Ecto.NoResultsError, fn -> Pet.get_animal!(animal.id) end
    end

    test "change_animal/1 returns a animal changeset" do
      animal = animal_fixture()
      assert %Ecto.Changeset{} = Pet.change_animal(animal)
    end
  end

  describe "posts" do
    alias PetFinder.Pet.Post

    @valid_attrs %{description: "some description", status: "some status"}
    @update_attrs %{description: "some updated description", status: "some updated status"}
    @invalid_attrs %{description: nil, status: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pet.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Pet.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Pet.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Pet.create_post(@valid_attrs)
      assert post.description == "some description"
      assert post.status == "some status"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pet.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Pet.update_post(post, @update_attrs)
      assert post.description == "some updated description"
      assert post.status == "some updated status"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Pet.update_post(post, @invalid_attrs)
      assert post == Pet.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Pet.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Pet.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Pet.change_post(post)
    end
  end
end
