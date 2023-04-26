defmodule Pokedex.Catalog.Region do
  use Ecto.Schema
  import Ecto.Changeset

  schema "regions" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
