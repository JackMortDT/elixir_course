defmodule EcommerceCourse.Items.BulkUpload do
  @moduledoc """
  Module for upload a huge quantity of items by CSV file
  """
  alias EcommerceCourse.Repo
  alias EcommerceCourse.Utils
  alias EcommerceCourse.Items.Item

  @doc """
    iex> path = "./priv/resources/items.csv"
  """
  def bulk_upload(file_path) do
    items =
      file_path
      |> File.stream!()
      |> CSV.decode(headers: true)
      |> Stream.map(fn row ->
        parser_row(row)
      end)
      |> Enum.to_list()

    Repo.insert_all(Item, items, conflict_target: [:sku], on_conflict: :nothing)
  end

  defp parser_row({:ok, row}) do
    row
    |> build_item_map()
    |> Utils.transform_string_map()
  end

  defp parser_row({_, _}), do: nil

  defp build_item_map(
         %{
           "price" => price,
           "quantity" => quantity
         } = item
       ) do
    date = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    Map.merge(item, %{
      "id" => Ecto.UUID.generate(),
      "inserted_at" => date,
      "updated_at" => date,
      "price" => transform_price_and_quantity(price, &Float.parse/1),
      "quantity" => transform_price_and_quantity(quantity, &Integer.parse/1)
    })
  end

  defp transform_price_and_quantity(price, func) do
    case func.(price) do
      {number, _} -> number
      _ -> 0
    end
  end
end
