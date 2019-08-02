defmodule PetFinderWeb.PageController do
  use PetFinderWeb, :controller
  alias PetFinder.Pet

  def index(conn, _params) do
    render(
      conn,
      "index.html",
      user_id: Plug.Conn.get_session(conn, :current_user_id),
      recently_lost_animals: Pet.get_recently_lost_animals!(),
      recently_found_animals: Pet.get_recently_found_animals!()
    )
  end
end
