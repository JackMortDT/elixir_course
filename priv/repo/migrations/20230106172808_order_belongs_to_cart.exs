defmodule EcommerceCourse.Repo.Migrations.OrderBelongsToCart do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :cart_id, references(:carts, type: :uuid), null: false
    end
  end
end
