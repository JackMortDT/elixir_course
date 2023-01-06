defmodule EcommerceCourse.Repo.Migrations.OrderBelongsToContactInfoUser do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :contact_info_id, references(:orders, type: :uuid), null: false
      add :user_id, references(:orders, type: :uuid), null: false
      add :payment_info, :map, null: false
    end
  end
end
