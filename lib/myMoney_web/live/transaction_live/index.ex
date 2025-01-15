defmodule MyMoneyWeb.TransactionLive.Index do
  use MyMoneyWeb, :live_view

  alias MyMoney.Finance
  alias MyMoney.Finance.Transaction

  @impl true
  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    {:ok, socket
      |> stream(:transactions, Finance.list_transactions())
      |> assign_async(:accounts_async, fn -> {:ok, %{accounts_async: Finance.list_accounts_options(user_id)}} end)
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    # IO.puts("Index page live action: #{socket.assigns.live_action}")
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Transaction")
    |> assign(:transaction, Finance.get_transaction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Transaction")
    |> assign(:transaction, %Transaction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Transactions")
    |> assign(:transaction, %Transaction{})
    |> IO.inspect(label: "new transaction set")
  end

  # defp get_empty_transaction(socket) do
  #   %Transaction{

  #   }
  # end

  @impl true
  def handle_info({MyMoneyWeb.TransactionLive.FormComponent, {:saved, transaction}}, socket) do
    {:noreply,
     socket
     |> stream_insert(
       :transactions,
       transaction
     )}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    transaction = Finance.get_transaction!(id)
    {:ok, _} = Finance.delete_transaction(transaction)

    {:noreply, stream_delete(socket, :transactions, transaction)}
  end
end
