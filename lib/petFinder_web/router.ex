defmodule PetFinderWeb.Router do
  use PetFinderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # auth routes
  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Auth]

    resources "/pets", PostController, only: [:create, :new, :delete, :edit]
    resources "/user", UserController, only: [:show, :edit, :delete]
    delete "/sign-out", SessionController, :delete
  end

  # guest routes
  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Guest]

    # get "/blog/:id", PostController, :show
    resources "/registrations", UserController, only: [:create, :new]
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
  end

  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Shared]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PetFinderWeb do
  #   pipe_through :api
  # end
end
