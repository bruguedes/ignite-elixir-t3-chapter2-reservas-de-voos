defmodule Flightex.Users.CreateOrUpdate do
  @moduledoc """
  Create user and save
  """
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Users.User

  def call(%{name: name, email: email, cpf: cpf}) do
    id = UUID.uuid4()

    id
    |> User.build(name, email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UsersAgent.save(user)
    {:ok, "User created or updated"}
  end

  defp save_user({:error, _} = error), do: error
end
