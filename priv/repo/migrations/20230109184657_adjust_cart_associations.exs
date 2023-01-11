defmodule EcommerceCourse.Repo.Migrations.AdjustCartAssociations do
  use Ecto.Migration

  def change do
    alter table(:carts) do
      add :user_id, references(:users, type: :uuid), null: false
    end
  end
end
