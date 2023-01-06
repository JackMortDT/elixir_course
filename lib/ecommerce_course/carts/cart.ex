defmodule EcommerceCourse.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Items.Item
  alias EcommerceCourse.Orders.Order
  @fields ~w(quantity)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "carts" do
    field :quantity, :integer, default: 0
    timestamps()

    many_to_many :items, Item, join_through: "cart_items"
    belongs_to :order, Order
  end

  @doc false
  def create_changeset(cart, attrs) do
    cart
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

  @doc false
  def update_changeset(cart, attrs) do
    cart
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
