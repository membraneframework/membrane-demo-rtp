defmodule GSTreamerTest do
  use ExUnit.Case

  alias Membrane.Element.UDP.Socket

  setup_all do
    data = [
      File.read!("test/rtp_h264_1_5.bin"),
      File.read!("test/rtp_h264_2_5.bin"),
      File.read!("test/rtp_h264_3_5.bin"),
      File.read!("test/rtp_h264_4_5.bin"),
      File.read!("test/rtp_h264_5_5.bin"),
      File.read!("test/end.bin")
    ]

    [data: data]
  end

  test "record gstreamer", %{data: data} do
    pid = UdpTest.iex_test()
    :timer.sleep(2000)

    {:ok, source} =
      %Socket{
        port_no: 4999,
        ip_address: {127, 0, 0, 1}
      }
      |> Socket.open()

    gstreamer = %Socket{
      port_no: 5001,
      ip_address: {127, 0, 0, 1}
    }

    membrane = %Socket{
      port_no: 5000,
      ip_address: {127, 0, 0, 1}
    }

    Enum.each(data, fn packet ->
      Socket.send(gstreamer, source, packet)
      Socket.send(membrane, source, packet)
    end)

    :timer.sleep(1000)
    Membrane.Pipeline.stop(pid)
  end
end
