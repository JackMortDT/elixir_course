defmodule EcommerceCourse.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false

      timestamps()
    end
  end
end
