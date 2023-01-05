defmodule EcommerceCourseWeb.ContactInfoControllerTest do
  use EcommerceCourseWeb.ConnCase

  import EcommerceCourse.OrdersFixtures

  alias EcommerceCourse.Orders.ContactInfo

  @create_attrs %{
    email: "some email",
    phone: "some phone"
  }
  @update_attrs %{
    email: "some updated email",
    phone: "some updated phone"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contact_info", %{conn: conn} do
      conn = get(conn, Routes.contact_info_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create contact_info" do
    test "renders contact_info when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contact_info_path(conn, :create), contact_info: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.contact_info_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some email",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update contact_info" do
    setup [:create_contact_info]

    test "renders contact_info when data is valid", %{
      conn: conn,
      contact_info: %ContactInfo{id: id} = contact_info
    } do
      conn =
        put(conn, Routes.contact_info_path(conn, :update, contact_info),
          contact_info: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.contact_info_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete contact_info" do
    setup [:create_contact_info]

    test "deletes chosen contact_info", %{conn: conn, contact_info: contact_info} do
      conn = delete(conn, Routes.contact_info_path(conn, :delete, contact_info))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.contact_info_path(conn, :show, contact_info))
      end
    end
  end

  defp create_contact_info(_) do
    contact_info = contact_info_fixture()
    %{contact_info: contact_info}
  end
end
