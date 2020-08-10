defmodule RockBanking.Banking.User do
  @moduledoc """
  This module cotains all the logic to interact with and manipulate banking users.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :balance, :float, default: 0.00, null: false
    field :email, :string, null: false, unique: true
    field :name, :string, null: false
    field :password, :string, null: true, virtual: true
    field :password_hash, :string, null: false

    timestamps()
  end

  @doc """
  Creates and configures a changeset to create a new user.
  """
  def create(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, is: 4)
    |> validate_password()
    |> put_password_hash()
  end

  def is_string_a_valid_integer?(string) do
    case Integer.parse(string) do
      {_, ""} -> true
      _ -> false
    end
  end

  def validate_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    case is_string_a_valid_integer?(password) do
      true -> changeset
      _ -> add_error(changeset, :password, "Invalid format")
    end
  end

  def validate_password(changeset), do: changeset

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
