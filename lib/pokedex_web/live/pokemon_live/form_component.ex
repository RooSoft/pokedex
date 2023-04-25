defmodule PokedexWeb.PokemonLive.FormComponent do
  use PokedexWeb, :live_component

  alias Pokedex.Catalog

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pokemon records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pokemon-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:pokedex_id]} type="number" label="Pokedex" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pokemon</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pokemon: pokemon} = assigns, socket) do
    changeset = Catalog.change_pokemon(pokemon)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pokemon" => pokemon_params}, socket) do
    changeset =
      socket.assigns.pokemon
      |> Catalog.change_pokemon(pokemon_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pokemon" => pokemon_params}, socket) do
    save_pokemon(socket, socket.assigns.action, pokemon_params)
  end

  defp save_pokemon(socket, :edit, pokemon_params) do
    case Catalog.update_pokemon(socket.assigns.pokemon, pokemon_params) do
      {:ok, pokemon} ->
        notify_parent({:saved, pokemon})

        {:noreply,
         socket
         |> put_flash(:info, "Pokemon updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pokemon(socket, :new, pokemon_params) do
    case Catalog.create_pokemon(pokemon_params) do
      {:ok, pokemon} ->
        notify_parent({:saved, pokemon})

        {:noreply,
         socket
         |> put_flash(:info, "Pokemon created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
