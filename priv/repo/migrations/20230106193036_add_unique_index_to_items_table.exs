defmodule EcommerceCourse.Repo.Migrations.AddUniqueIndexToItemsTable do
  use Ecto.Migration

  def change do
    create unique_index(:items, :sku)
  end
end
