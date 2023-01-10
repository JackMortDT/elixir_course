defmodule EcommerceCourseWeb.CartView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.CartView

  def render("index.json", %{carts: carts}) do
    %{data: render_many(carts, CartView, "cart.json")}
  end

  def render("show.json", %{cart: cart}) do
    %{data: render_one(cart, CartView, "cart.json")}
  end

  def render("cart.json", %{cart: %{id: id, user: user, carts: carts}}) do
    %{
      id: id,
      username: user.username,
      cart_items: render_many(carts, CartView, "show_cart_item.json")
    }
  end

  def render("show_cart_item.json", %{cart: params}) do
    %{
      id: params.id,
      quantity: params.quantity
    }
  end
end
