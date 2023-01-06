defmodule EcommerceCourse.Repo.Migrations.AddIndexToOrdersTable do
  use Ecto.Migration

  def change do
    create index(:orders, [:updated_at, :status])
    create index(:orders, [:price])
    create index(:orders, [:delivery_date])
  end
end
