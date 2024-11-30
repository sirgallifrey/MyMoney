defmodule MyMoney.Repo do
  use Ecto.Repo,
    otp_app: :myMoney,
    adapter: Ecto.Adapters.Postgres
end
