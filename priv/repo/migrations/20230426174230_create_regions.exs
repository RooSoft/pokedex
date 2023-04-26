defmodule Pokedex.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions, primary_key: false) do
      add :id, :integer, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
