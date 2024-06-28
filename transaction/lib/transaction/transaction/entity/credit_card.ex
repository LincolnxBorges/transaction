defmodule Transaction.Transaction.Entity.CreditCard do
  use Ecto.Schema
  import Ecto.Changeset

  alias Transaction.Transaction.Entity.Customer

  schema "credit_card" do
    field(:name, :string)
    field(:brand, :string)
    field(:number, :integer)
    field(:cvv, :integer)
    field(:expiration_date, :string)

    belongs_to(:customer, Customer)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:brand, :number, :cvv, :name, :expiration_date])
    |> validate_required([:brand, :number, :cvv, :name, :expiration_date])
    |> validate_length(:number, is: 16)
    |> validate_length(:cvv, is: 3)
  end
end
