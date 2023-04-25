defmodule Pokedex.Importer.Pokemons do
  def get(region_id) do
    Req.get!("https://pokeapi.co/api/v2/pokedex/#{region_id}").body["pokemon_entries"]
    |> Enum.map(fn
      %{
        "pokemon_species" => %{
          "name" => name,
          "url" => url
        }
      } ->
        pokedex_id =
          url
          |> String.split("/")
          |> Enum.at(-2)

        {pokedex_id, name}
    end)
  end

  def upsert(pokemons) do
    for {pokedex_id, name} <- pokemons do
      Pokedex.Catalog.upsert_pokemon(%{name: name, pokedex_id: pokedex_id})
    end
  end
end
