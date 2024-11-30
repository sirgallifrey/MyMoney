defmodule MyMoney.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyMoney.Finance` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 42,
        currency: "some currency",
        description: "some description"
      })
      |> MyMoney.Finance.create_transaction()

    transaction
  end

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        description: "some description",
        name: "some name"
      })
      |> MyMoney.Finance.create_account()

    account
  end
end
