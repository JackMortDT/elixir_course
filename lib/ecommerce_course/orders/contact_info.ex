defmodule EcommerceCourse.Orders.ContactInfo do
  use EcommerceCourse.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Addresses.Address

  @fields ~w(email phone address_id)a
  @email_address_regex ~r/^([a-zA-Z0-9_\-\.\+]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/

  schema "contact_info" do
    field :email, :string
    field :phone, :string

    timestamps()

    belongs_to :address, Address
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_format(:email, @email_address_regex)
    |> validate_required(@fields)
  end

  @doc false
  def update_changeset(contact_info, attrs) do
    contact_info
    |> cast(attrs, @fields)
  end
end
