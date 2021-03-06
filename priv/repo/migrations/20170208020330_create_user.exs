defmodule SentinelExample.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email,    :text
      add :username, :text
      add :role, :text
      add :password, :string #why have?
      add :hashed_password, :text
      add :hashed_confirmation_token, :text
      add :confirmed_at, :utc_datetime
      add :hashed_password_reset_token, :text
      add :unconfirmed_email,    :text
      timestamps
    end

    create index(:users, [:email], unique: true)
    create index(:users, [:username], unique: true)
  end
end
