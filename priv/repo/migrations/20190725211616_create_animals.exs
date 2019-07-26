defmodule PetFinder.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals) do
      add :species, :string
      add :color, {:array, :string}
      add :location, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:animals, [:user_id])
  end
end
