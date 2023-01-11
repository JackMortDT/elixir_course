defmodule EcommerceCourse.Repo.Migrations.OrderBelongsToContactInfoUser do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :contact_info_id, references(:contact_info, type: :uuid), null: false
      add :user_id, references(:users, type: :uuid), null: false
      add :payment_info, :map
    end
  end
end
