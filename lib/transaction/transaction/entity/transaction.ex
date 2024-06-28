defmodule Transaction.Transaction.Entity.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Transaction.Transaction.Entity.{Customer, Shipment, CreditCard, DebitCard, Item, Pix}

  schema "transactions" do
    field :payment_method, :string
    field :amount, :decimal
    field :installments, :integer
    belongs_to :customer, Customer
    belongs_to :shipment, Shipment
    belongs_to :credit_card, CreditCard, on_replace: :delete
    belongs_to :debit_card, DebitCard, on_replace: :delete
    belongs_to :pix, Pix, on_replace: :delete
    has_many :items, Item
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:payment_method, :amount, :installments])
    |> validate_required([:payment_method, :amount])
    |> validate_number(:amount, greater_than: 0)
    |> validate_number(:installments, less_than_or_equal_to: 12, allow_nil: true)
    |> cast_assoc(:customer, required: true, with: &Customer.changeset/2)
    |> cast_dynamic_payment_method()
    |> convert_amount()
  end

  defp cast_dynamic_payment_method(changeset) do
    case get_change(changeset, :payment_method) do
      "credit_card" ->
        changeset
        |> validate_required([:installments])
        |> validate_inclusion(:brand, ["Visa", "MasterCard"])
        |> cast_assoc(:shipment, required: true, with: &Shipment.changeset/2)
        |> cast_assoc(:credit_card, with: &CreditCard.changeset/2)
        |> merge_changeset_errors(:credit_card)

      "debit_card" ->
        changeset
        |> validate_required([:installments])
        |> validate_inclusion(:brand, ["Visa", "MasterCard"])
        |> cast_assoc(:shipment, required: true, with: &Shipment.changeset/2)
        |> cast_assoc(:debit_card, with: &DebitCard.changeset/2)
        |> merge_changeset_errors(:debit_card)

      "pix" ->
        changeset
        |> cast_assoc(:pix, with: &Pix.changeset/2)
        |> merge_changeset_errors(:pix)

      _ ->
        changeset
    end
  end

  defp merge_changeset_errors(changeset, assoc) do
    case get_change(changeset, assoc) do
      %Ecto.Changeset{valid?: false} = assoc_changeset ->
        Enum.reduce(assoc_changeset.errors, changeset, fn {key, {msg, opts}}, acc ->
          add_error(acc, :"#{assoc}_#{key}", msg, opts)
        end)

      _ ->
        changeset
    end
  end

  defp convert_amount(changeset) do
    changeset
    |> put_change(:amount, Decimal.mult(get_change(changeset, :amount), Decimal.new(100)))
  end
end
