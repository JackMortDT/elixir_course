defmodule EcommerceCourse.Addresses.Address do
  use EcommerceCourse.Schema
  import Ecto.Changeset
  alias EcommerceCourse.Users.User

  @required_fields ~w(country_code postal_code street neighborhood user_id)a
  @optional_fields ~w(reference)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "addresses" do
    field :country_code, :string
    field :neighborhood, :string
    field :postal_code, :string
    field :reference, :string
    field :street, :string

    timestamps()

    belongs_to :user, User
  end

  @doc false
  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end

  @doc false
  def update_changeset(address, attrs) do
    address
    |> cast(attrs, @optional_fields ++ @required_fields)
  end
end
