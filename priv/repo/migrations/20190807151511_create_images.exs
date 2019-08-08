defmodule PetFinder.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :image, :string
      add :animal_id, references(:animals, on_delete: :nothing)

      timestamps()
    end
    create index(:images, [:animal_id])
  end
end
