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


    resources "/user", UserController, only: [:show, :edit, :delete] do
      resources "/animals", AnimalController, except: [:show] do
        resources "/posts", PostController, only: [:create, :new, :delete, :edit]
      end
    end
    delete "/sign-out", SessionController, :delete
  end

  # guest routes
  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Guest]

    resources "/registrations", UserController, only: [:create, :new]
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
  end

  #auth routes
  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Shared]

    get "/", PageController, :index
    get "/user/:user_id/animals/:id", AnimalController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", PetFinderWeb do
  #   pipe_through :api
  # end
end
