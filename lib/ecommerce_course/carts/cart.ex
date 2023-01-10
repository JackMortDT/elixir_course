defmodule EcommerceCourse.Carts.Cart do
  use EcommerceCourse.Schema
  import Ecto.Changeset

  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Carts.CartItem

  schema "carts" do
    belongs_to :user, User
    has_many :carts, CartItem

    timestamps()
  end

  @doc false
  def create_changeset(cart, attrs) do
    cart
    |> cast(attrs, [:user_id])
  end
end
