defmodule Flightex.Bookings.Report do
  @moduledoc """
  Gnerate report
  """
  alias Flightex.Bookings.{Agent, Booking}

  def generate(filename \\ "report.csv") do
    order_list = build_bookings_list()

    File.write(filename, order_list)
  end

  def generate_report(from_date, to_date) do
    Agent.list_all()
    |> Map.values()
    |> filter_for_date(from_date, to_date)
    |> Enum.map(fn booking -> booking_string(booking) end)
    |> Enum.map(fn booking -> booking <> "\n" end)
    |> generate_csv()
  end

  defp generate_csv([]), do: "Booking not found"
  defp generate_csv([_head | _tail] = list), do: File.write("report_for_date.csv", list)

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

  defp filter_for_date(list, from_date, to_date) do
    Enum.filter(list, fn %Booking{complete_date: date} = booking ->
      with {:ok, _} <- range_date(from_date, date),
           {:ok, _} <- range_date(date, to_date) do
        booking
      end
    end)
  end

  def range_date(date1, date2) do
    case NaiveDateTime.compare(date1, date2) do
      :lt ->
        {:ok, true}

      :eq ->
        {:ok, true}

      :gt ->
        nil
    end
  end
end
