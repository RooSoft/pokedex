defmodule Pokedex.Catalog.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemons" do
    field :name, :string
    field :pokedex_id, :integer

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :pokedex_id])
    |> validate_required([:name, :pokedex_id])
  end
end
