defmodule FlightexTest do
  use ExUnit.Case, async: true
  alias Flightex

  setup do
    Flightex.start_agents()
    :ok
  end

  describe "create_or_update_user/1" do
    test "sucess, create booking" do
      params = %{
        name: "Bruno",
        email: "bruno@teste.com",
        cpf: "12312312"
      }

      response = Flightex.create_or_update_user(params)
      assert {:ok, "User created or updated"} == response
    end

    test "fail, create booking" do
      params = %{
        name: "Bruno",
        email: "bruno@teste.com",
        cpf: 12_312_312
      }

      response = Flightex.create_or_update_user(params)
      assert {:error, "Cpf must be a String"} == response
    end
  end

  describe "create_or_update_booking/1" do
    test "sucess, create booking" do
      params = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900"
      }

      response = Flightex.create_or_update_booking(params)
      assert {:ok, _uuid} = response
    end

    test "fail, create booking" do
      params = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: 12_345_678_900
      }

      response = Flightex.create_or_update_booking(params)
      assert {:error, "Invalid Params"} == response
    end
  end
end
