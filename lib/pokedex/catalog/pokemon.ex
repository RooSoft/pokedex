defmodule Pokedex.Catalog.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :name, :string
    field :names, :map

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:id, :name, :names])
    |> validate_required([:id, :name ])
  end
end
