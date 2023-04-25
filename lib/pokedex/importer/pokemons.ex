defmodule Pokedex.Importer.Pokemons do
  def get() do
    Req.get!("https://pokeapi.co/api/v2/pokemon-species?limit=2000").body["results"]
    |> Enum.map(fn
      %{
        "name" => name,
        "url" => url
      } ->
        pokedex_id =
          url
          |> String.split("/")
          |> Enum.at(-2)

        {pokedex_id, name}
    end)
  end

  def get_name_translations(pokedex_id) do
    Req.get!("https://pokeapi.co/api/v2/pokemon-species/#{pokedex_id}").body["names"] 
    |> Enum.map(fn %{"name" => name, "language" => %{"name" => language_name}} -> 
      {language_name, name}
    end)
  end

  def upsert(pokemons) do
    for {pokedex_id, name} <- pokemons do
      Pokedex.Catalog.upsert_pokemon(%{name: name, pokedex_id: pokedex_id})
    end
  end
end
