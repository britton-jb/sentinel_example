defmodule SentinelExample.UserTest do
  use SentinelExample.ModelCase

  alias SentinelExample.User

  @valid_attrs %{confirmed_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, email: "some content", hashed_confirmation_token: "some content", unconfirmed_email: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
