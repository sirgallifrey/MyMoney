defmodule MyMoney.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :description, :string
    field :amount, :integer
    field :account_name, :string, virtual: true
    belongs_to :account, MyMoney.Finance.Account

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :description, :account_id])
    |> validate_required([:amount, :description, :account_id])
  end
end
