defmodule EcommerceCourse.OrdersTest do
  use EcommerceCourse.DataCase

  alias EcommerceCourse.Orders

  describe "orders" do
    alias EcommerceCourse.Orders.Order

    import EcommerceCourse.OrdersFixtures

    @invalid_attrs %{delivery_date: nil, location: nil, price: nil, status: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{
        delivery_date: ~U[2023-01-04 18:23:00.000000Z],
        location: "some location",
        price: 120.5,
        status: "some status"
      }

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.delivery_date == ~U[2023-01-04 18:23:00.000000Z]
      assert order.location == "some location"
      assert order.price == 120.5
      assert order.status == "some status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()

      update_attrs = %{
        delivery_date: ~U[2023-01-05 18:23:00.000000Z],
        location: "some updated location",
        price: 456.7,
        status: "some updated status"
      }

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.delivery_date == ~U[2023-01-05 18:23:00.000000Z]
      assert order.location == "some updated location"
      assert order.price == 456.7
      assert order.status == "some updated status"
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "contact_info" do
    alias EcommerceCourse.Orders.ContactInfo

    import EcommerceCourse.OrdersFixtures

    @invalid_attrs %{email: nil, phone: nil}

    test "list_contact_info/0 returns all contact_info" do
      contact_info = contact_info_fixture()
      assert Orders.list_contact_info() == [contact_info]
    end

    test "get_contact_info!/1 returns the contact_info with given id" do
      contact_info = contact_info_fixture()
      assert Orders.get_contact_info!(contact_info.id) == contact_info
    end

    test "create_contact_info/1 with valid data creates a contact_info" do
      valid_attrs = %{email: "some email", phone: "some phone"}

      assert {:ok, %ContactInfo{} = contact_info} = Orders.create_contact_info(valid_attrs)
      assert contact_info.email == "some email"
      assert contact_info.phone == "some phone"
    end

    test "create_contact_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_contact_info(@invalid_attrs)
    end

    test "update_contact_info/2 with valid data updates the contact_info" do
      contact_info = contact_info_fixture()
      update_attrs = %{email: "some updated email", phone: "some updated phone"}

      assert {:ok, %ContactInfo{} = contact_info} =
               Orders.update_contact_info(contact_info, update_attrs)

      assert contact_info.email == "some updated email"
      assert contact_info.phone == "some updated phone"
    end

    test "delete_contact_info/1 deletes the contact_info" do
      contact_info = contact_info_fixture()
      assert {:ok, %ContactInfo{}} = Orders.delete_contact_info(contact_info)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_contact_info!(contact_info.id) end
    end

    test "change_contact_info/1 returns a contact_info changeset" do
      contact_info = contact_info_fixture()
      assert %Ecto.Changeset{} = Orders.change_contact_info(contact_info)
    end
  end
end
