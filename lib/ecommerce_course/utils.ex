defmodule EcommerceCourse.Utils do
  @moduledoc """
  Utils for EcommerceCourse project
  """

  def transform_string_map(map) do
    Enum.reduce(map, %{}, fn {key, value}, acc ->
      Map.put(acc, String.to_atom(key), value)
    end)
  end
end
