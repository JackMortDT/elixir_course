defmodule EcommerceCourse.AddressesTest do
  use EcommerceCourse.DataCase

  alias EcommerceCourse.Addresses

  describe "addresses" do
    alias EcommerceCourse.Addresses.Address

    import EcommerceCourse.AddressesFixtures

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{
        country_code: "some country_code",
        neighborhood: "some neighborhood",
        postal_code: "some postal_code",
        reference: "some reference",
        street: "some street"
      }

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.country_code == "some country_code"
      assert address.neighborhood == "some neighborhood"
      assert address.postal_code == "some postal_code"
      assert address.reference == "some reference"
      assert address.street == "some street"
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()

      update_attrs = %{
        country_code: "some updated country_code",
        neighborhood: "some updated neighborhood",
        postal_code: "some updated postal_code",
        reference: "some updated reference",
        street: "some updated street"
      }

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.country_code == "some updated country_code"
      assert address.neighborhood == "some updated neighborhood"
      assert address.postal_code == "some updated postal_code"
      assert address.reference == "some updated reference"
      assert address.street == "some updated street"
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
