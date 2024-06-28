defmodule Transaction.Transaction.Application.CreateTransaction do
  alias Transaction.Transaction.Entity.Transaction

  # def execute(%{"payment_method" => "credit_card"} = attrs) do

  # end

  def execute(attrs) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> validate_changeset()
  end

  def execute(_, _) do
    {:error, "Invalid method of payment."}
  end

  defp validate_changeset(changeset) do
    case changeset.valid? do
      true -> {:ok, Ecto.Changeset.apply_changes(changeset)}
      false -> {:error, changeset}
    end
  end
end
