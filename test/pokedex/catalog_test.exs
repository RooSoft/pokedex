defmodule Pokedex.CatalogTest do
  use Pokedex.DataCase

  alias Pokedex.Catalog

  describe "pokemons" do
    alias Pokedex.Catalog.Pokemon

    import Pokedex.CatalogFixtures

    @invalid_attrs %{name: nil, id: nil}

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Catalog.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Catalog.get_pokemon!(pokemon.id) == pokemon
    end

    test "upsert_pokemon/1 with valid data creates a pokemon" do
      valid_attrs = %{name: "some name", id: 42}

      assert {:ok, %Pokemon{} = pokemon} = Catalog.upsert_pokemon(valid_attrs)
      assert pokemon.name == "some name"
      assert pokemon.id == 42
    end

    test "upsert_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.upsert_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      update_attrs = %{name: "some updated name", id: 43}

      assert {:ok, %Pokemon{} = pokemon} = Catalog.update_pokemon(pokemon, update_attrs)
      assert pokemon.name == "some updated name"
      assert pokemon.id == 43
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Catalog.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Catalog.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Catalog.change_pokemon(pokemon)
    end
  end
end
