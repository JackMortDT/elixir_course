defmodule EcommerceCourse.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EcommerceCourse.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        last_logged_in: ~U[2023-01-04 18:18:00.000000Z],
        password: "some password",
        username: "some username"
      })
      |> EcommerceCourse.Users.create_user()

    user
  end
end
