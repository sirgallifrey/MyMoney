defmodule MyMoney.Finance.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :name, :string
    field :description, :string
    field :currency, :string
    has_many :transactions, MyMoney.Finance.Transaction
    belongs_to :user, MyMoney.Accounts.User

    timestamps(type: :utc_datetime)
  end

  def to_form_option(account) do
    {account.name, account.id}
  end

  def to_form_options(accounts) do
    accounts
    |> Enum.map(fn acc -> to_form_option(acc) end)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :description, :currency, :user_id])
    |> validate_required([:name, :currency, :user_id])
  end
end
