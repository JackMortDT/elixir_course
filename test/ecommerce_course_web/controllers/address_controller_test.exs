defmodule EcommerceCourseWeb.AddressControllerTest do
  use EcommerceCourseWeb.ConnCase

  import EcommerceCourse.AddressesFixtures

  alias EcommerceCourse.Addresses.Address

  @create_attrs %{
    country_code: "some country_code",
    neighborhood: "some neighborhood",
    postal_code: "some postal_code",
    reference: "some reference",
    street: "some street"
  }
  @update_attrs %{
    country_code: "some updated country_code",
    neighborhood: "some updated neighborhood",
    postal_code: "some updated postal_code",
    reference: "some updated reference",
    street: "some updated street"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, Routes.address_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post(conn, Routes.address_path(conn, :create), address: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "country_code" => "some country_code",
               "neighborhood" => "some neighborhood",
               "postal_code" => "some postal_code",
               "reference" => "some reference",
               "street" => "some street"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put(conn, Routes.address_path(conn, :update, address), address: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.address_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "country_code" => "some updated country_code",
               "neighborhood" => "some updated neighborhood",
               "postal_code" => "some updated postal_code",
               "reference" => "some updated reference",
               "street" => "some updated street"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, Routes.address_path(conn, :delete, address))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.address_path(conn, :show, address))
      end
    end
  end

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end
end
