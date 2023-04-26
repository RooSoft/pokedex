defmodule Pokedex.Importer.PokeAPI.PokemonNames do
  def get_all do
    query = """
      query searchForPokemonInFrench($_in: [String!] = ["en", "fr"]) {
        pokemon_v2_pokemonspecies(
          where: {
            pokemon_v2_pokemonspeciesnames: {
              pokemon_v2_language: {
                name: {_in: ["en", "fr"]}
              }
            }
          }
        ) 
        {
          pokemon_v2_pokemonspeciesnames(
            where: {pokemon_v2_language: {}}
          ) 
          {
            name
            pokemon_v2_language {
              name
            }
          }
          id
        }
      }
    """

    Neuron.Config.set(url: "https://beta.pokeapi.co/graphql/v1beta")

    case Neuron.query(query) do
      {:ok, %Neuron.Response{} = response} ->
        extract_pokemons(response.body)

      {:error, message} ->
        message
    end
  end

  defp extract_pokemons(%{"data" => %{"pokemon_v2_pokemonspecies" => names}}) do
    names
    |> Enum.map(fn %{"id" => id, "pokemon_v2_pokemonspeciesnames" => raw_pokemon} ->
      {id, extract_names(raw_pokemon)}
    end)
  end

  defp extract_names(raw_names) do
    raw_names
    |> Enum.map(fn %{"name" => name, "pokemon_v2_language" => %{"name" => language}} ->
      {language, name}
    end)
    |> Enum.into(%{})
  end
end
