defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: false

  import Flightex.Factory

  alias Flightex.Bookings.Report

  describe "generate/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params = %{
        complete_date: ~N[2001-05-07 12:00:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900"
      }

      content = "12345678900, Brasilia, Bananeiras,2001-05-07 12:00:00"

      Flightex.create_or_update_booking(params)
      Report.generate("report-test.csv")
      file = File.read!("report-test.csv")

      assert file == content
    end
  end

  describe "generate_report" do
    setup do
      Flightex.start_agents()

      Enum.map(1..12, fn x ->
        date = NaiveDateTime.new!(2020, x, 2 * x, 0, 0, 0)
        params = build(:booking, complete_date: date)
        Flightex.create_or_update_booking(params)
      end)

      :ok
    end

    test "success, report generated when filter apply" do
      content = "12345678900, Brasilia, Bananeiras,2020-01-02 00:00:00\n"

      Report.generate_report(~N[2019-07-01 00:00:00], ~N[2020-02-01 00:00:00])
      file = File.read!("report_for_date.csv")
      assert file == content
    end

    test "fail,  when filter apply returns empty" do
      assert "Booking not found" ==
               Report.generate_report(~N[2019-07-01 00:00:00], ~N[2019-10-30 00:00:00])
    end
  end
end
