defmodule EcommerceCourse.Repo.Migrations.ContactInfoBelongsToAddress do
  use Ecto.Migration

  def change do
    alter table(:contact_info) do
      add :address_id, references(:addresses, type: :uuid), null: false
    end
  end
end
