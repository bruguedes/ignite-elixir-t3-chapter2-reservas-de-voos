defmodule Flightex.Users.User do
  @moduledoc """
  Struct
  """
  @keys [:name, :email, :cpf, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(id, name, email, cpf) when is_binary(cpf) do
    {:ok,
     %__MODULE__{
       id: id,
       name: name,
       email: email,
       cpf: cpf
     }}
  end

  def build(_name, _email, _cpf, _id), do: {:error, "Invalid parameters"}
end
