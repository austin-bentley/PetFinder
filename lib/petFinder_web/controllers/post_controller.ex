defmodule PetFinderWeb.PostController do
  use PetFinderWeb, :controller

  alias PetFinder.Pet
  alias PetFinder.Pet.Post

  # def index(conn, _params) do
  #   posts = Pet.list_posts()
  #   render(conn, "index.html", posts: posts)
  # end

  def new(conn, _params) do
    changeset = Pet.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Pet.create_post(post_params) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, conn.assigns.user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   post = Pet.get_post!(id)
  #   render(conn, "show.html", post: post)
  # end

  # def edit(conn, %{"animal_id" => _animal_id, "id" => id, "user_id" => _user_id}) do
  #   post = Pet.get_post!(id)
  #   changeset = Pet.change_post(post)
  #   render(conn, "edit.html", post: post, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "post" => post_params}) do
  #   post = Pet.get_post!(id)

  #   case Pet.update_post(post, post_params) do
  #     {:ok, post} ->
  #       conn
  #       |> put_flash(:info, "Post updated successfully.")
  #       |> redirect(to: Routes.user_animal_path(conn, :show, conn.assigns.user_id, post.animal_id))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", post: post, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   post = Pet.get_post!(id)
  #   {:ok, _post} = Pet.delete_post(post)

  #   conn
  #   |> put_flash(:info, "Post deleted successfully.")
  #   |> redirect(to: Routes.post_path(conn, :index))
  # end
end
