defmodule Pokedex.Importer.PokeAPI.RegionPokemons do
  def get_all do
    Pokedex.Repo.all(Pokedex.Catalog.Region)
    |> Enum.map(fn region ->
      {region.id, get_pokemon_ids(region.id)}
    end)
  end

  defp get_pokemon_ids(region_id) do
    query = "https://pokeapi.co/api/v2/pokedex/#{region_id}"

    case Req.get(query) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        body
        |> Map.get("pokemon_entries")
        |> Enum.map(fn entry ->
          Map.get(entry, "pokemon_species")
          |> Map.get("url")
          |> String.split("/")
          |> Enum.at(-2)
          |> Integer.parse()
          |> elem(0)
        end)
        |> Enum.sort()

      {:ok, _} ->
        []

      {:error, _} ->
        []
    end
  end
end
