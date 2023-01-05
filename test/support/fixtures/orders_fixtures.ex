defmodule EcommerceCourse.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EcommerceCourse.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        delivery_date: ~U[2023-01-04 18:23:00.000000Z],
        location: "some location",
        price: 120.5,
        status: "some status"
      })
      |> EcommerceCourse.Orders.create_order()

    order
  end

  @doc """
  Generate a contact_info.
  """
  def contact_info_fixture(attrs \\ %{}) do
    {:ok, contact_info} =
      attrs
      |> Enum.into(%{
        email: "some email",
        phone: "some phone"
      })
      |> EcommerceCourse.Orders.create_contact_info()

    contact_info
  end
end
