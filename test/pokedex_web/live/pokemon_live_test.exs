defmodule PokedexWeb.PokemonLiveTest do
  use PokedexWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pokedex.CatalogFixtures

  defp upsert_pokemon(_) do
    pokemon = pokemon_fixture()
    %{pokemon: pokemon}
  end

  describe "Index" do
    setup [:upsert_pokemon]

    test "lists all pokemons", %{conn: conn, pokemon: pokemon} do
      {:ok, _index_live, html} = live(conn, ~p"/pokemons")

      assert html =~ "Listing Pokemons"
      assert html =~ pokemon.name
    end
  end

  describe "Show" do
    setup [:upsert_pokemon]

    test "displays pokemon", %{conn: conn, pokemon: pokemon} do
      {:ok, _show_live, html} = live(conn, ~p"/pokemons/#{pokemon}")

      assert html =~ "Show Pokemon"
      assert html =~ pokemon.name
    end
  end
end
