defmodule EcommerceCourse.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EcommerceCourse.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        country_code: "some country_code",
        neighborhood: "some neighborhood",
        postal_code: "some postal_code",
        reference: "some reference",
        street: "some street"
      })
      |> EcommerceCourse.Addresses.create_address()

    address
  end
end
