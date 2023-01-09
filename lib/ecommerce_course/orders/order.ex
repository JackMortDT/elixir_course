defmodule EcommerceCourse.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Orders.{ContactInfo, PaymentInfo}

  @required_fields ~w(delivery_date location price status)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "orders" do
    field :delivery_date, :utc_datetime_usec
    field :location, :string
    field :price, :float
    field :status, :string

    timestamps()

    belongs_to :contact_info, ContactInfo
    belongs_to :user, User
    belongs_to :cart, Cart
    embeds_one(:payment_info, PaymentInfo, on_replace: :update)
  end

  @doc false
  def create_changeset(order, attrs) do
    order
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(order, attrs) do
    order
    |> cast(attrs, @required_fields)
  end
end
