defmodule Pokedex.Repo.Migrations.CreatePokemonNames do
  use Ecto.Migration

  def change do
    create table(:pokemon_names) do
      add :pokemon_id, :integer
      add :language, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:pokemon_names, [:pokemon_id, :language])
  end
end

