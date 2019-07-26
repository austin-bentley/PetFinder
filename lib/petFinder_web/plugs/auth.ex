defmodule PetFinderWeb.Plugs.Auth do
  import Phoenix.Controller
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
      case Plug.Conn.get_session(conn, :current_user_id) do
        nil ->
          conn
          |> redirect(to: "/sign-in")
          |> halt()
        resp ->
          conn
          |> assign(:user_id, resp)
      end
  end
end
