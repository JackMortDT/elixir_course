defmodule EcommerceCourseWeb.ItemControllerTest do
  use EcommerceCourseWeb.ConnCase

  import EcommerceCourse.ItemsFixtures

  alias EcommerceCourse.Items.Item

  @create_attrs %{
    description: "some description",
    image: "some image",
    inventory_updated_add: ~U[2023-01-04 18:10:00.000000Z],
    name: "some name",
    price: 120.5,
    quantity: 42,
    sku: "some sku"
  }
  @update_attrs %{
    description: "some updated description",
    image: "some updated image",
    inventory_updated_add: ~U[2023-01-05 18:10:00.000000Z],
    name: "some updated name",
    price: 456.7,
    quantity: 43,
    sku: "some updated sku"
  }
  @invalid_attrs %{
    description: nil,
    image: nil,
    inventory_updated_add: nil,
    name: nil,
    price: nil,
    quantity: nil,
    sku: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, Routes.item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create item" do
    test "renders item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "image" => "some image",
               "inventory_updated_add" => "2023-01-04T18:10:00.000000Z",
               "name" => "some name",
               "price" => 120.5,
               "quantity" => 42,
               "sku" => "some sku"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.item_path(conn, :create), item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update item" do
    setup [:create_item]

    test "renders item when data is valid", %{conn: conn, item: %Item{id: id} = item} do
      conn = put(conn, Routes.item_path(conn, :update, item), item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.item_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "image" => "some updated image",
               "inventory_updated_add" => "2023-01-05T18:10:00.000000Z",
               "name" => "some updated name",
               "price" => 456.7,
               "quantity" => 43,
               "sku" => "some updated sku"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, Routes.item_path(conn, :delete, item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.item_path(conn, :show, item))
      end
    end
  end

  defp create_item(_) do
    item = item_fixture()
    %{item: item}
  end
end
