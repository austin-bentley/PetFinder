defmodule PetFinderWeb.PageController do
  use PetFinderWeb, :controller
  alias PetFinder.Pet

  def index(conn, _params) do
    userId = Plug.Conn.get_session(conn, :current_user_id)
    recently_lost_animals = Pet.get_recently_lost_animals!();
    render(conn, "index.html", user_id: userId, recently_lost: recently_lost_animals)
  end
end
