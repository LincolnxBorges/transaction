defmodule Transaction.Transaction.Entity.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Transaction.Transaction.Entity.Transaction

  schema "items" do
    field :name, :string
    field :price, :decimal
    field :quantity, :integer
    belongs_to :transaction, Transaction
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :price, :quantity, :transaction_id])
    |> validate_required([:name, :price, :quantity, :transaction_id])
    |> validate_number(:price, greater_than: 0)
    |> validate_number(:quantity, greater_than: 0)
  end
end
