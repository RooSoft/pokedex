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
end
