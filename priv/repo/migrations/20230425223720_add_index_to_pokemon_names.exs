defmodule Pokedex.Repo.Migrations.AddIndexToPokemonNames do
  use Ecto.Migration

  def up do
    execute("CREATE INDEX pokemons_names ON pokemons USING GIN(names)")
  end

  def down do
    execute("DROP INDEX pokemons_names")
  end
end
