defmodule Pokedex.Repo.Migrations.AddPokemonNameTraductions do
  use Ecto.Migration

  def change do
    alter table(:pokemons) do
      add :names, :map, default: %{}
    end
  end
end
