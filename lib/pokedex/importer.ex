defmodule Pokedex.Importer do
  alias Pokedex.Importer.Pokemons

  def update_all do
    Pokemons.get() |> Pokemons.upsert()  
  end
end
