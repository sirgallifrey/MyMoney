defmodule MyMoneyWeb.AccountLive.Index do
  use MyMoneyWeb, :live_view

  alias MyMoney.Finance
  alias MyMoney.Finance.Account

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :accounts, Finance.list_accounts(socket.assigns.current_user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Account")
    |> assign(:account, Finance.get_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account")
    |> assign(:account, %Account{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Accounts")
    |> assign(:account, nil)
  end

  @impl true
  def handle_info({MyMoneyWeb.AccountLive.FormComponent, {:saved, account}}, socket) do
    {:noreply, stream_insert(socket, :accounts, account)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    account = Finance.get_account!(id)
    {:ok, _} = Finance.delete_account(account)

    {:noreply, stream_delete(socket, :accounts, account)}
  end
end
