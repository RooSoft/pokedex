defmodule Pokedex.Repo.Migrations.CreatePokemonNames do
  use Ecto.Migration

  def change do
    create table(:pokemon_names, primary_key: false) do
      add :id, :integer, primary_key: true
      add :pokemon_id, :integer
      add :language, :string
      add :name, :string

      timestamps()
    end
  end
end

