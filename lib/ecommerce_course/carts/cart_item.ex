defmodule EcommerceCourse.Carts.CartItem do
  use EcommerceCourse.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Items.Item

  @creation_fields ~w(quantity cart_id item_id price)a
  @updatable_fields ~w(quantity price)a

  schema "cart_items" do
    field :quantity, :integer
    field :price, :float

    belongs_to :cart, Cart
    belongs_to :item, Item
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @creation_fields)
    |> validate_required(@creation_fields)
  end

  def update_changeset(cart_item, attrs) do
    cart_item
    |> cast(attrs, @updatable_fields)
  end
end
