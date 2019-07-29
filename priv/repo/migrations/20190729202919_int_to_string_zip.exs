defmodule PetFinder.Repo.Migrations.IntToStringZip do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify(:zip_code, :string)
    end

    alter table("animals") do
      modify(:location, :string)
    end
  end
end
