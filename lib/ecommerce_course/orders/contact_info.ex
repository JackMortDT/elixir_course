defmodule EcommerceCourse.Orders.ContactInfo do
  use Ecto.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Addresses.Address

  @fields ~w(email phone)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "contact_info" do
    field :email, :string
    field :phone, :string

    timestamps()

    belongs_to :address, Address
  end

  @doc false
  def create_changeset(contact_info, attrs) do
    contact_info
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

  @doc false
  def update_changeset(contact_info, attrs) do
    contact_info
    |> cast(attrs, @fields)
  end
end
