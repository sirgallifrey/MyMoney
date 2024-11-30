defmodule MyMoneyWeb.TransactionLive.FormComponent do
  use MyMoneyWeb, :live_component

  alias MyMoney.Finance

  attr :title, :string, default: nil

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header :if={@title != nil}>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id={"transaction-form-#{@id}"}
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="md:flex gap-4 flex-end md:place-items-end">
        <.input :if={accounts = @accounts_async.ok? && @accounts_async.result} field={@form[:account_id]} type="select" label="Account" id_prefix={@id} prompt="Select your account" options={accounts}/>
        <.input field={@form[:amount]} type="number" label="Amount" id_prefix={@id}/>
        <div class="flex-grow"><.input field={@form[:description]} type="text" label="Description" id_prefix={@id}/></div>
        <.button class="mt-2 no-wrap" phx-disable-with="Saving...">Save Transaction</.button>

        </div>
          <%!-- <:actions>
            <.button phx-disable-with="Saving...">Save Transaction</.button>
          </:actions> --%>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{transaction: transaction} = assigns, socket) do
    # IO.inspect(assigns, label: "Form Update")
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Finance.change_transaction(transaction))
     end)}
  end

  @impl true
  def handle_event("validate", %{"transaction" => transaction_params}, socket) do
    changeset = Finance.change_transaction(socket.assigns.transaction, transaction_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"transaction" => transaction_params}, socket) do
    save_transaction(socket, socket.assigns.action, transaction_params)
  end

  defp save_transaction(socket, :edit, transaction_params) do
    case Finance.update_transaction(socket.assigns.transaction, transaction_params) do
      {:ok, transaction} ->
        notify_parent({:saved, transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Transaction updated successfully")
         |> push_socket_patch()}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_transaction(socket, :new, transaction_params) do
    case Finance.create_transaction(transaction_params) do
      {:ok, transaction} ->
        notify_parent({:saved, transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Transaction created successfully")
         |> push_socket_patch()}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_transaction(socket, :index, transaction_params) do
    save_transaction(socket, :new, transaction_params)
  end

  defp push_socket_patch (socket) do
    if socket.assigns[:patch] != nil do
      socket
      |> push_patch(to: socket.assigns.patch)
    else
      socket
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
