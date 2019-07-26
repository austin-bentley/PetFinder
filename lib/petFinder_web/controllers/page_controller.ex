defmodule PetFinderWeb.PageController do
  use PetFinderWeb, :controller

  def index(conn, _params) do
    userId = Plug.Conn.get_session(conn, :current_user_id)
    render(conn, "index.html", user_id: userId)
  end
end
