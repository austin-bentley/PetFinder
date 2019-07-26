defmodule PetFinder.Repo do
  use Ecto.Repo,
    otp_app: :petFinder,
    adapter: Ecto.Adapters.Postgres
end
