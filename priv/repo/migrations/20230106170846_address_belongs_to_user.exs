defmodule EcommerceCourse.Repo.Migrations.AddressBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:addresses) do
      add :user_id, references(:users, type: :uuid), null: false
    end
  end
end
