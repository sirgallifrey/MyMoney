defmodule MyMoney.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :description, :string
      add :account_id, references(:accounts)

      timestamps(type: :utc_datetime)
    end
  end
end
