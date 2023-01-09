defmodule EcommerceCourse.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Carts.CartItem

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "carts" do
    belongs_to :user, User
    has_many :carts, CartItem

    timestamps()
  end

  @doc false
  def create_changeset(cart, attrs) do
    IO.inspect(attrs)

    cart
    |> cast(attrs, [:user_id])
  end
end
