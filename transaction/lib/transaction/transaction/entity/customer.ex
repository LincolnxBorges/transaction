defmodule Transaction.Transaction.Entity.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customer" do
    field(:name, :string)
    field(:cpf, :string)
    field(:phone, :string)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :cpf, :phone])
    |> validate_required([:name, :cpf, :phone])
    |> validate_format(:cpf, ~r/^\d{3}\.\d{3}\.\d{3}\-\d{2}$/)
  end
end
