defmodule Pokedex.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons) do
      add :name, :string
      add :pokedex_id, :integer

      timestamps()
    end
  end
end
