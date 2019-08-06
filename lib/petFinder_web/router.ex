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


    resources "/user", UserController, only: [:edit, :delete]
    resources "/animals", AnimalController, except: [:show, :index] do
      resources "/posts", PostController, only: [:create, :new, :delete, :edit]
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

  #Shared routes
  scope "/", PetFinderWeb do
    pipe_through [:browser, PetFinderWeb.Plugs.Shared]

    get "/", PageController, :index
    get "/user/:user_id/animals/:id", AnimalController, :show

    resources "/user", UserController, only: [:index, :show]
    resources "/animals", AnimalController, only: [:show, :index]

  end

  # Other scopes may use custom stacks.
  # scope "/api", PetFinderWeb do
  #   pipe_through :api
  # end
end
