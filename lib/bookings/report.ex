defmodule Flightex.Bookings.Report do
  @moduledoc """
  Gnerate report
  """
  alias Flightex.Bookings.{Agent, Booking}

  def generate(filename \\ "report.csv") do
    order_list = build_bookings_list()

    File.write(filename, order_list)
  end

  defp build_bookings_list do
    Agent.list_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         user_id: user_id,
         local_origin: local_origin,
         local_destination: local_destination,
         complete_date: complete_date
       }) do
    "#{user_id}, #{local_origin}, #{local_destination},#{complete_date}"
  end
end
