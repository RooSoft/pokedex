defmodule Pokedex.Catalog.PokemonName do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pokemon_names" do
    field :language, :string
    field :name, :string

    belongs_to :pokemon, Pokedex.Catalog.Pokemon

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:pokemon_id, :language, :name])
    |> validate_required([:pokemon_id, :language, :name])
  end
end
