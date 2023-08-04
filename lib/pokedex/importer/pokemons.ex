defmodule Pokedex.Importer.Pokemons do
  alias Pokedex.Importer.PokeAPI.PokemonNames

  def get() do
    Req.get!("https://pokeapi.co/api/v2/pokemon-species?limit=2000").body["results"]
    |> Enum.map(fn
      %{
        "name" => name,
        "url" => url
      } ->
        id =
          url
          |> String.split("/")
          |> Enum.at(-2)

        {id, name}
    end)
  end

  def get_name_translations(id) do
    Req.get!("https://pokeapi.co/api/v2/pokemon-species/#{id}").body["names"]
    |> Enum.map(fn %{"name" => name, "language" => %{"name" => language_name}} ->
      {language_name, name}
    end)
    |> Enum.into(%{})
  end

  def upsert(pokemons) do
    for {id, name} <- pokemons do
      Pokedex.Catalog.upsert_pokemon(%{name: name, id: id})
    end
  end

  def translate do
    pokemon_names = PokemonNames.get_all

    for {id, %{"en" => en, "fr" => fr, "ja" => jp}} <- pokemon_names do
      Pokedex.Catalog.upsert_pokemon_name(%{pokemon_id: id, language: "en", name: en})
      Pokedex.Catalog.upsert_pokemon_name(%{pokemon_id: id, language: "fr", name: fr})
      Pokedex.Catalog.upsert_pokemon_name(%{pokemon_id: id, language: "jp", name: jp})
    end
  end
end
