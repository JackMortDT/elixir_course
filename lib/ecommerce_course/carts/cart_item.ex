defmodule EcommerceCourse.Carts.CartItem do
  use Ecto.Schema

  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Items.Item

  @primary_key false

  schema "cart_items" do
    belongs_to :carts, Cart
    belongs_to :items, Item
  end
end
