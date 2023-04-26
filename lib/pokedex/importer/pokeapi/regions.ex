defmodule Pokedex.Importer.PokeAPI.Regions do
  def get_all do
    query = """
      query RegionNameQuery {
        pokemon_v2_region {
          id
          name
        }
      }
    """

    Neuron.Config.set(url: "https://beta.pokeapi.co/graphql/v1beta")

    case Neuron.query(query) do
      {:ok, %Neuron.Response{} = response} ->
        extract_regions(response.body)

      {:error, message} ->
        message
    end
  end

  defp extract_regions(%{"data" => %{"pokemon_v2_region" => regions}}) do
    regions
    |> Enum.map(fn %{"id" => id, "name" => name} ->
      {id, name}
    end)
  end
end
