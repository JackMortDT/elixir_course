defmodule EcommerceCourse.Schema do
  @moduledoc """
  Module for schema defaults
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type Ecto.UUID
    end
  end
end
