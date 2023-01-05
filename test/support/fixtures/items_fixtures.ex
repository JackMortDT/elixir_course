defmodule EcommerceCourse.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EcommerceCourse.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        inventory_updated_add: ~U[2023-01-04 18:10:00.000000Z],
        name: "some name",
        price: 120.5,
        quantity: 42,
        sku: "some sku"
      })
      |> EcommerceCourse.Items.create_item()

    item
  end
end
