defmodule EcommerceCourse.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :name, :string
      add :quantity, :integer
      add :price, :float
      add :description, :string
      add :image, :string
      add :sku, :string
      add :inventory_updated_add, :utc_datetime_usec

      timestamps()
    end
  end
end
