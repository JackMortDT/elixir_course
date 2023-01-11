defmodule EcommerceCourse.Checkout do
  @moduledoc """
  Checkout logic
  """

  alias Ecto.Multi
  alias EcommerceCourse.Orders.Order
  alias EcommerceCourse.Items.Item
  alias EcommerceCourse.Repo

  def submit_order(%Order{cart: %{items: []}}, _payment_info) do
    {:error, "Empty cart"}
  end

  def submit_order(order, payment) do
    with :ok <- validate_phone(order),
         {:ok, alg} <- verify_order(order, payment) do
      {:ok, alg.update_payment_info}
    end
  end

  defp validate_phone(%{contact_info: %{phone: phone}}) when is_binary(phone) do
    :ok
  end

  defp validate_phone(_order), do: {:error, "Phone number required for checkout"}

  defp verify_order(order, payment) do
    Multi.new()
    |> Multi.update(:order, Order.update_changeset(order, %{status: "in_process"}))
    |> Multi.merge(fn _somethin ->
      order
      |> Repo.preload(cart: [items: :item])
      |> apply_inventory_reductions()
    end)
    |> Multi.run(:update_payment_info, fn repo, %{order: order} ->
      order = Repo.preload(order, cart: [items: :item])
      save_payment_info(payment, order) |> repo.update()
    end)
    |> Repo.transaction()
  end

  defp apply_inventory_reductions(%{cart: %{items: []}}) do
    {:error, "Cars does not have items"}
  end

  defp apply_inventory_reductions(%{cart: %{items: items}}) do
    items
    |> Enum.reduce(Multi.new(), fn %{quantity: qty, item: item}, multi ->
      multi
      |> Multi.update(
        :item,
        Item.update_changeset(item, %{quantity: item.quantity - qty})
      )
    end)
  end

  defp save_payment_info(
         %{payment_method: "credit_card", card_number: card_number} = payment_info,
         order
       ) do
    card_number
    |> String.length()
    |> create_payment_struct(payment_info, order)
    |> then(&Order.payment_changeset(order, &1))
  end

  defp save_payment_info(_paymet_info, _order),
    do: {:error, "Credit card required for checkout"}

  defp create_payment_struct(16 = _card_lenght, payment_info, %{
         contact_info: %{email: email},
         cart: %{items: items}
       }) do
    %{
      last_four: payment_info.card_number |> String.slice(12..15),
      email: email,
      amount: Enum.reduce(items, 0.0, &(&1.price + &2))
    }
  end

  defp create_payment_struct(_card_lenght, _payment_info, _order),
    do: {:error, "Please validate card number"}
end
