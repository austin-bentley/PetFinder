defmodule PetFinderWeb.Plugs.Auth do
  import Phoenix.Controller
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    if !Plug.Conn.get_session(conn, :current_user_id) do
      conn
      |> redirect(to: "/sign-in")
      |> halt()
    end
    conn
  end
end
