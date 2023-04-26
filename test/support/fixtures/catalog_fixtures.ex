defmodule Pokedex.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pokedex.Catalog` context.
  """

  @doc """
  Generate a pokemon.
  """
  def pokemon_fixture(attrs \\ %{}) do
    {:ok, pokemon} =
      attrs
      |> Enum.into(%{
        id: 42,
        name: "some name",
        names: %{}
      })
      |> Pokedex.Catalog.upsert_pokemon()

    pokemon
  end
end
