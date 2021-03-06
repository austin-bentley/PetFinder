defmodule PetFinderWeb.Plugs.Guest do
  import Phoenix.Controller
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    case Plug.Conn.get_session(conn, :current_user_id) do
      nil ->
        conn
      _resp ->
        conn
        |> redirect(to: "/")
        |> halt()
    end
  end
end
