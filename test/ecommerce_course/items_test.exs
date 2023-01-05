defmodule EcommerceCourse.ItemsTest do
  use EcommerceCourse.DataCase

  alias EcommerceCourse.Items

  describe "items" do
    alias EcommerceCourse.Items.Item

    import EcommerceCourse.ItemsFixtures

    @invalid_attrs %{
      description: nil,
      image: nil,
      inventory_updated_add: nil,
      name: nil,
      price: nil,
      quantity: nil,
      sku: nil
    }

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{
        description: "some description",
        image: "some image",
        inventory_updated_add: ~U[2023-01-04 18:10:00.000000Z],
        name: "some name",
        price: 120.5,
        quantity: 42,
        sku: "some sku"
      }

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.description == "some description"
      assert item.image == "some image"
      assert item.inventory_updated_add == ~U[2023-01-04 18:10:00.000000Z]
      assert item.name == "some name"
      assert item.price == 120.5
      assert item.quantity == 42
      assert item.sku == "some sku"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()

      update_attrs = %{
        description: "some updated description",
        image: "some updated image",
        inventory_updated_add: ~U[2023-01-05 18:10:00.000000Z],
        name: "some updated name",
        price: 456.7,
        quantity: 43,
        sku: "some updated sku"
      }

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.description == "some updated description"
      assert item.image == "some updated image"
      assert item.inventory_updated_add == ~U[2023-01-05 18:10:00.000000Z]
      assert item.name == "some updated name"
      assert item.price == 456.7
      assert item.quantity == 43
      assert item.sku == "some updated sku"
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
