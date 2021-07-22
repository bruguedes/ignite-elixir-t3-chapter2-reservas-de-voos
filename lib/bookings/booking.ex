defmodule Flightex.Bookings.Booking do
  @moduledoc """
  Struct
  """

  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(date, origin, destiny, user_id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       complete_date: date,
       local_origin: origin,
       local_destination: destiny,
       user_id: user_id
     }}
  end
end
