defmodule PokedexWeb.PokemonLive.Index do
  use PokedexWeb, :live_view

  alias Pokedex.Catalog
  alias Pokedex.Catalog.Pokemon

  @impl true
  def mount(_params, _session, socket) do
    pokemons = get_pokemons()

    {
      :ok,
      socket
      |> assign(:pokemons, pokemons)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({PokedexWeb.PokemonLive.FormComponent, {:saved, pokemon}}, socket) do
    {:noreply, stream_insert(socket, :pokemons, pokemon)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pokemon = Catalog.get_pokemon!(id)
    {:ok, _} = Catalog.delete_pokemon(pokemon)

    {:noreply, stream_delete(socket, :pokemons, pokemon)}
  end

  @impl true
  def handle_event("name_changed", %{"pokemon_name" => name}, socket) do
    pokemons = get_pokemons(name)

    {
      :noreply,
      socket
      |> assign(:pokemons, pokemons)
    }
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pokemon")
    |> assign(:pokemon, Catalog.get_pokemon!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pokemon")
    |> assign(:pokemon, %Pokemon{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pokemons")
    |> assign(:pokemon, nil)
  end

  defp get_name(pokemon) do
    case pokemon.names do
      %{"en" => english, "fr" => french} -> "#{english} - #{french}"
      _ -> pokemon.name
    end
  end

  defp get_pokemons() do
    get_pokemons("")
  end

  defp get_pokemons(name) do
    Catalog.list_pokemons(name)
    |> Enum.sort(&(&1.id < &2.id))
  end
end
