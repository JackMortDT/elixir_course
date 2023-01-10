defmodule EcommerceCourse.Carts do
  @moduledoc """
  The Carts context.
  """

  import Ecto.Query, warn: false
  alias EcommerceCourse.Utils
  alias EcommerceCourse.Repo

  alias EcommerceCourse.Carts.Cart
  alias EcommerceCourse.Carts.CartItem

  @doc """
  Returns the list of carts.

  ## Examples

      iex> list_carts()
      [%Cart{}, ...]

  """
  def list_carts do
    Repo.all(Cart) |> preload_cart()
  end

  @doc """
  Gets a single cart.

  Raises `Ecto.NoResultsError` if the Cart does not exist.

  ## Examples

      iex> get_cart!(123)
      %Cart{}

      iex> get_cart!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart!(id), do: Repo.get!(Cart, id)

  @doc """
  Creates a cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart(attrs \\ %{}) do
    %Cart{}
    |> Cart.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a cart.

  ## Examples

      iex> delete_cart(cart)
      {:ok, %Cart{}}

      iex> delete_cart(cart)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart(%Cart{} = cart) do
    Repo.delete(cart)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart changes.

  ## Examples

      iex> change_cart(cart)
      %Ecto.Changeset{data: %Cart{}}

  """
  def change_cart(%Cart{} = cart, attrs \\ %{}) do
    Cart.create_changeset(cart, attrs)
  end

  @doc """
  Create cart items and adding to cart

  iex> add_cart_items(item_id, quantity)
  """
  def add_cart_items(attrs) do
    attrs = Utils.transform_string_map(attrs)

    attrs
    |> validate_cart_item()
    |> case do
      nil ->
        %CartItem{}
        |> CartItem.create_changeset(attrs)
        |> Repo.insert()

      cart ->
        update_cart_item(cart, attrs)
    end
  end

  def update_cart_item(cart, attrs) do
    quantity = cart_item_quantity(cart.quantity, attrs.quantity)

    cart
    |> CartItem.update_changeset(%{quantity: quantity})
    |> Repo.update()
  end

  defp cart_item_quantity(cart_quantity, updatable_quantity) do
    quantity = cart_quantity + updatable_quantity

    if quantity <= 0 do
      0
    else
      quantity
    end
  end

  defp validate_cart_item(%{item_id: item_id, cart_id: cart_id}) do
    CartItem
    |> where([ci], ci.item_id == ^item_id)
    |> where([ci], ci.cart_id == ^cart_id)
    |> Repo.one()
  end

  def preload_cart(cart) do
    Repo.preload(cart, [:user, :carts])
  end
end
