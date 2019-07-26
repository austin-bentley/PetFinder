defmodule PetFinder.Account.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :zip_code, :integer, defaul: nil
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password])
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> update_change(:encrypted_password, &Bcrypt.hashpwsalt/1)
  end
end
