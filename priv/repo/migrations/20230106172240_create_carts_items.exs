defmodule EcommerceCourse.Repo.Migrations.CreateCartsItems do
  use Ecto.Migration

  def change do
    create table(:carts_items, primary_key: false) do
      add :cart_id, references(:carts, type: :uuid), null: false
      add :item_id, references(:items, type: :uuid), null: false
    end

    create unique_index(:carts_items, [:cart_id, :item_id])
  end
end
