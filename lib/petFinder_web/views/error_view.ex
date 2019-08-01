defmodule PetFinderWeb.ErrorView do
  use PetFinderWeb, :view
  use Phoenix.Endpoint, otp_app: :petFinder
  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("500.html", _assigns) do
    "Internal Server Error"
  end

  def render("404.html", assigns) do
    error_data = %{
      message: "Oops something went wrong",
      status: assigns.conn.status,
      conn: assigns.conn
    }
    render(PetFinderWeb.ErrorView, "404.html", error_data)
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
