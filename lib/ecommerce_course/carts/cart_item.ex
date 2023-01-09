defmodule EcommerceCourse.Carts.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Items.Item

  @fields ~w(quantity cart_id item_id)a

  @primary_key false
  schema "cart_items" do
    field :quantity, :integer

    belongs_to :cart, Cart
    belongs_to :item, Item
  end

  def changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
