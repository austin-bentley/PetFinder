defmodule PetFinderWeb.SessionController do
  use PetFinderWeb, :controller

  alias PetFinder.Account

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    user = Account.get_by_username(auth_params["username"])
    case Comeonin.Bcrypt.check_pass(user, auth_params["password"]) do
    {:ok, user} ->
      conn
      |> put_session(:current_user_id, user.id)
      |> put_flash(:info, "Signed in successfully!")
      |> redirect(to: "/")
    {:error, _} ->
      conn
      |> put_flash(:error, "There was a problem with your username/password")
      |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: "/")
  end
end
