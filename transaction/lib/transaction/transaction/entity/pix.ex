defmodule Transaction.Transaction.Entity.Pix do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Transaction.Transaction.Entity.Customer

  schema "pix" do
    field(:pix_key, :string)
    field(:description, :string)
    field(:brand, :string)
    field(:transaction_date, :utc_datetime)
  end

  @doc false
  def changeset(pix, attrs) do
    pix
    |> cast(attrs, [:pix_key, :description, :brand, :transaction_date])
    |> validate_required([:pix_key, :description, :brand, :transaction_date])
  end
end
