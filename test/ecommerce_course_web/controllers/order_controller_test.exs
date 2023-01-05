defmodule EcommerceCourseWeb.OrderControllerTest do
  use EcommerceCourseWeb.ConnCase

  import EcommerceCourse.OrdersFixtures

  alias EcommerceCourse.Orders.Order

  @create_attrs %{
    delivery_date: ~U[2023-01-04 18:23:00.000000Z],
    location: "some location",
    price: 120.5,
    status: "some status"
  }
  @update_attrs %{
    delivery_date: ~U[2023-01-05 18:23:00.000000Z],
    location: "some updated location",
    price: 456.7,
    status: "some updated status"
  }
  @invalid_attrs %{delivery_date: nil, location: nil, price: nil, status: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, Routes.order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "delivery_date" => "2023-01-04T18:23:00.000000Z",
               "location" => "some location",
               "price" => 120.5,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_path(conn, :create), order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, Routes.order_path(conn, :update, order), order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "delivery_date" => "2023-01-05T18:23:00.000000Z",
               "location" => "some updated location",
               "price" => 456.7,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_path(conn, :show, order))
      end
    end
  end

  defp create_order(_) do
    order = order_fixture()
    %{order: order}
  end
end
