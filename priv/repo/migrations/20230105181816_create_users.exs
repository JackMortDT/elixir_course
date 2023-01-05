defmodule EcommerceCourse.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :username, :string
      add :password, :string
      add :email, :string
      add :last_logged_in, :utc_datetime_usec

      timestamps()
    end
  end
end
