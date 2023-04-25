defmodule Pokedex.Importer do
  alias Pokedex.Importer.Pokemons

  def update_all do
    Pokemons.get(3) |> Pokemons.upsert()  
  end
end
