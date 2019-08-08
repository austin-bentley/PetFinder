defmodule PetFinderWeb.Helpers.Auth do

  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!PetFinder.Repo.get(PetFinder.Account.User, user_id)
  end

  def is_owner?(conn, author) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id == author, do: true
  end

  def is_route_sign_in_or_up(%{request_path: path }) when path == "/sign-in" or path == "/registrations/new", do: true
  def is_route_sign_in_or_up(_conn), do: false

  def is_home_page?(%{request_path: path }) when path == "/", do: true
  def is_home_page?(_conn), do: false
end
