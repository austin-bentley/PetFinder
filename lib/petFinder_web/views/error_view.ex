defmodule PetFinderWeb.ErrorView do
  use PetFinderWeb, :view
  use Phoenix.Endpoint, otp_app: :petFinder

  alias PetFinder.Pet
  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("500.html", assigns) do
    render(PetFinderWeb.ErrorView,
      "error.html",
      message: "It's raining cats and dogs over here! Please give us some time to sort this out",
      status: assigns.conn.status,
      conn: assigns.conn,
      posts: Pet.list_posts
    )
  end

  def render("404.html", assigns) do
    render(PetFinderWeb.ErrorView,
      "error.html",
      message: "Oops something went wrong",
      status: assigns.conn.status,
      conn: assigns.conn,
      posts: Pet.list_posts
    )
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
