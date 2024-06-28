defmodule Transaction.Transaction.Application.CreateTransactionTest do
  use Transaction.DataCase, async: true

  alias Transaction.Transaction.Application.CreateTransaction

  # @valid_credit_card %{
  #   "payment_method" => "credit_card",
  #   "amount" => 123.45,
  #   "customer" => %{
  #     "name" => "Betinho337",
  #     "cpf" => "123.456.789-10",
  #     "phone" => "(94) 99999-9999"
  #   },
  #   "shipment" => %{
  #     "address" => "Rua 0",
  #     "city" => "Parauapebas",
  #     "state" => "Pará",
  #     "country" => "Brasil",
  #     "zip_code" => "65815-000"
  #   },
  #   "card" => %{
  #     "name" => "Betinho337",
  #     "brand" => "Visa",
  #     "number" => 1234_5678_9123_4567,
  #     "cvv" => 123,
  #     "expiration_date" => "12/12/1234"
  #   },
  #   "installments" => 12
  # }

  # @valid_debit_card %{
  #   "payment_method" => "debit_card",
  #   "amount" => 123.45,
  #   "customer" => %{
  #     "name" => "Betinho337",
  #     "cpf" => "123.456.789-10",
  #     "phone" => "(94) 99999-9999"
  #   },
  #   "shipment" => %{
  #     "address" => "Rua 0",
  #     "city" => "Parauapebas",
  #     "state" => "Pará",
  #     "country" => "Brasil",
  #     "zip_code" => "65815-000"
  #   },
  #   "card" => %{
  #     "name" => "Betinho337",
  #     "brand" => "Visa",
  #     "number" => 1234_5678_9123_4567,
  #     "cvv" => 123,
  #     "expiration_date" => "12/12/1234"
  #   },
  #   "installments" => 12
  # }

  @valid_pix %{
    "payment_method" => "pix",
    "amount" => 123.45,
    "pix" => %{
      "pix_key" => "12345678910",
      "description" => "Pix payment",
      "brand" => "Pix",
      "transaction_date" => "2021-12-12T12:12:12Z"
    },
    "customer" => %{
      "name" => "Betinho337",
      "cpf" => "123.456.789-10",
      "phone" => "(94) 99999-9999"
    }
  }

  test "creates a transaction with pix" do
    {check, transaction} = CreateTransaction.execute(@valid_pix)
    IO.inspect(transaction)
    assert check == :ok
    assert transaction.payment_method == "pix"
    assert transaction.amount == Decimal.new("12345.00")
    assert transaction.pix.pix_key == "12345678910"
  end
end
