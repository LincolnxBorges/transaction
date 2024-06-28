defmodule Transaction.Transaction.Entity.Shipment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipment" do
    field(:address, :string)
    field(:city, :string)
    field(:state, :string)
    field(:country, :string)
    field(:zip_code, :string)
  end

  @doc false
  def changeset(shipment, attrs) do
    shipment
    |> cast(attrs, [:address, :city, :state, :country, :zip_code])
    |> validate_required([:address, :city, :state, :country, :zip_code])
  end
end
