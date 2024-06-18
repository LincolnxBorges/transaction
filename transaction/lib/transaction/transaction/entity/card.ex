defmodule Transaction.Transaction.Entity.Card do
  use Ecto.Schema
  import Ecto.Changeset

  schema "card" do
    field :brand, :string
    field :number, :integer
    field :cvv, :integer
    field :name, :string
    field :expiration_date, :string

    timestamp(type: :utc_datetime)
  end

  def changeset(card, attrs) do
    card
    |> cast(attrs, [:brand, :number, :cvv, :name, :expiration_date])
    |> validate_required([:brand, :number, :cvv, :name, :expiration_date])
  end
end
