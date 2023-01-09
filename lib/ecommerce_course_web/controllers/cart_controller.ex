defmodule EcommerceCourseWeb.CartController do
  use EcommerceCourseWeb, :controller

  alias EcommerceCourse.Carts
  alias EcommerceCourse.Carts.Cart
  # alias EcommerceCourse.Items
  # alias EcommerceCourse.Items.Item

  action_fallback EcommerceCourseWeb.FallbackController

  def index(conn, _params) do
    carts = Carts.list_carts()
    render(conn, "index.json", carts: carts)
  end

  def create(conn, _params) do
    user = conn.private.guardian_default_resource

    with {:ok, user_uuid} <- Ecto.UUID.cast(user.id),
         {:ok, %Cart{} = cart} <-
           Carts.create_cart(%{user_id: user_uuid}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Carts.get_cart!(id)
    render(conn, "show.json", cart: cart)
  end

  def delete(conn, %{"id" => id}) do
    cart = Carts.get_cart!(id)

    with {:ok, %Cart{}} <- Carts.delete_cart(cart) do
      send_resp(conn, :no_content, "")
    end
  end
end
