defmodule MyMoney.FinanceTest do
  use MyMoney.DataCase

  alias MyMoney.Finance

  describe "transactions" do
    alias MyMoney.Finance.Transaction

    import MyMoney.FinanceFixtures

    @invalid_attrs %{description: nil, currency: nil, amount: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Finance.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Finance.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{description: "some description", currency: "some currency", amount: 42}

      assert {:ok, %Transaction{} = transaction} = Finance.create_transaction(valid_attrs)
      assert transaction.description == "some description"
      assert transaction.currency == "some currency"
      assert transaction.amount == 42
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{description: "some updated description", currency: "some updated currency", amount: 43}

      assert {:ok, %Transaction{} = transaction} = Finance.update_transaction(transaction, update_attrs)
      assert transaction.description == "some updated description"
      assert transaction.currency == "some updated currency"
      assert transaction.amount == 43
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_transaction(transaction, @invalid_attrs)
      assert transaction == Finance.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Finance.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Finance.change_transaction(transaction)
    end
  end

  describe "accounts" do
    alias MyMoney.Finance.Account

    import MyMoney.FinanceFixtures

    @invalid_attrs %{name: nil, description: nil, currency: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Finance.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Finance.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{name: "some name", description: "some description", currency: "some currency"}

      assert {:ok, %Account{} = account} = Finance.create_account(valid_attrs)
      assert account.name == "some name"
      assert account.description == "some description"
      assert account.currency == "some currency"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", currency: "some updated currency"}

      assert {:ok, %Account{} = account} = Finance.update_account(account, update_attrs)
      assert account.name == "some updated name"
      assert account.description == "some updated description"
      assert account.currency == "some updated currency"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_account(account, @invalid_attrs)
      assert account == Finance.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Finance.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Finance.change_account(account)
    end
  end
end
