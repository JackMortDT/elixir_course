defmodule EcommerceCourse.Repo.Migrations.AddIndexToItemsTable do
  use Ecto.Migration

  def change do
    create index(:items, [:name])
    create index(:items, [:name, :sku])
  end
end
