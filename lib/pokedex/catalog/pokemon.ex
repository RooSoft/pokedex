defmodule Pokedex.Catalog.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :name, :string

    has_many :names, Pokedex.Catalog.PokemonName

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
