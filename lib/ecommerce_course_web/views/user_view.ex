defmodule EcommerceCourseWeb.UserView do
  use EcommerceCourseWeb, :view
  alias EcommerceCourseWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      password: user.password,
      email: user.email,
      last_logged_in: user.last_logged_in
    }
  end
end
