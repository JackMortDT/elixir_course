defmodule EcommerceCourse.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name price quantity sku)a
  @optional_fields ~w(description image inventory_updated_add)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "items" do
    field :description, :string
    field :image, :string
    field :inventory_updated_add, :utc_datetime_usec
    field :name, :string
    field :price, :float
    field :quantity, :integer
    field :sku, :string

    timestamps()
  end

  @doc false
  def create_changeset(item, attrs) do
    item
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end

  def update_changeset(item, attrs) do
    item
    |> cast(attrs, @optional_fields ++ @required_fields)
  end
end
