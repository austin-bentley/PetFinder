defmodule PetFinderWeb.PageController do
  use PetFinderWeb, :controller
  alias PetFinder.Pet

  def index(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    render(
      conn,
      "index.html",
      user_id: user_id,
      recently_lost_animals: Pet.get_recently_lost_animals!(),
      recently_found_animals: Pet.get_recently_found_animals!(),
      # posts_near_user: Pet.get_posts_near_user(user_id)
    )
  end
end
