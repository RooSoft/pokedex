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
        name: "some name",
        pokedex_id: 42
      })
      |> Pokedex.Catalog.create_pokemon()

    pokemon
  end
end
