defmodule Pokedex.Importer.Regions do
  def upsert(regions) do
    for {id, name} <- regions do
      Pokedex.Catalog.upsert_region(%{name: name, id: id})
    end
  end
end

