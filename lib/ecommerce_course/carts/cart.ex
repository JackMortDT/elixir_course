defmodule EcommerceCourse.Carts.Cart do
  use EcommerceCourse.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Orders.Order
  alias EcommerceCourse.Carts.CartItem

  schema "carts" do
    belongs_to :user, User
    has_many :items, CartItem
    has_one :order, Order

    timestamps()
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:user_id])
  end
end
