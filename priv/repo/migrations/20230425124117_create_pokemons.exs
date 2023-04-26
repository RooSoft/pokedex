defmodule Pokedex.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :integer, primary_key: true
      add :name, :string
      add :names, :map, default: %{}

      timestamps()
    end
  end

  def up do
    execute("CREATE INDEX pokemons_names ON pokemons USING GIN(names)")
  end

  def down do
    execute("DROP INDEX pokemons_names")
  end
end
