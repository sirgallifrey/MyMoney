defmodule MyMoney.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :description, :string
      add :currency, :string, size: 3
      add :user_id, references(:users)

      timestamps(type: :utc_datetime)
    end
  end
end
