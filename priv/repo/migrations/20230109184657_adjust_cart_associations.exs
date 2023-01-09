defmodule EcommerceCourse.Repo.Migrations.AdjustCartAssociations do
  use Ecto.Migration

  def change do
    alter table(:carts_items) do
      add :quantity, :integer, null: false
    end

    alter table(:carts) do
      add :user_id, references(:users, type: :uuid), null: false
    end
  end
end
