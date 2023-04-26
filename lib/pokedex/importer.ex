defmodule Pokedex.Importer do
  alias Pokedex.Importer.{PokeAPI, Pokemons, Regions}

  def update_all do
    Pokemons.get() |> Pokemons.upsert()
    Pokemons.translate()

    PokeAPI.Regions.get_all |> Regions.upsert()
  end
end
