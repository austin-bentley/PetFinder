defmodule PetFinder.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :description, :text
      add :status, :string
      add :animal_id, references(:animals, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:animal_id])
  end
end
