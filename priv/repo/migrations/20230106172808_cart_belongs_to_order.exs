defmodule EcommerceCourse.Repo.Migrations.CartBelongsToOrder do
  use Ecto.Migration

  def change do
    alter table(:carts) do
      add :order_id, references(:orders, type: :uuid), null: false
    end
  end
end
