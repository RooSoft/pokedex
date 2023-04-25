defmodule PokedexWeb.PokemonLive.Show do
  use PokedexWeb, :live_view

  alias Pokedex.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pokemon, Catalog.get_pokemon!(id))}
  end

  defp page_title(:show), do: "Show Pokemon"
  defp page_title(:edit), do: "Edit Pokemon"

  defp get_image_src(pokedex_id) do
    # "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/#{pokedex_id}.svg"
    # "https://img.pokemondb.net/artwork/large/bulbasaur.jpg"
    # "https://img.pokemondb.net/artwork/large/walking-wake.jpg"
    # "https://archives.bulbagarden.net/media/upload/f/fb/0001Bulbasaur.png"
    # "https://archives.bulbagarden.net/media/upload/b/bc/1009Walking_Wake.png"
    # "https://assets.pokemon.com/assets/cms2/img/pokedex/full/1003.png"
    # "https://static.wikia.nocookie.net/pokemon/images/8/86/900px-Walking_Wake.png"

    id = pokedex_id |> Integer.to_string() |> String.pad_leading(3, "0")

    "https://assets.pokemon.com/assets/cms2/img/pokedex/full/#{id}.png"
  end
end
