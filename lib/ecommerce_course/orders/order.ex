defmodule EcommerceCourse.Orders.Order do
  use EcommerceCourse.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Users.User
  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Orders.{ContactInfo, PaymentInfo}

  @required_fields ~w(location contact_info_id user_id cart_id)a

  schema "orders" do
    field :delivery_date, :utc_datetime_usec
    field :location, :string
    field :price, :float
    # created, in_process, in_transit, completed
    field :status, :string

    belongs_to :contact_info, ContactInfo
    belongs_to :user, User
    belongs_to :cart, Cart
    embeds_one(:payment_info, PaymentInfo, on_replace: :update)

    timestamps()
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(order, attrs) do
    order
    |> cast(attrs, @required_fields)
  end

  def payment_changeset(order, payment_info) do
    order
    |> cast(%{}, [])
    |> put_embed(:payment_info, payment_info)
  end
end
