defmodule PcapTest do
  use Membrane.Pipeline

  def iex_test do
    {:ok, pid} = Membrane.Pipeline.start_link(__MODULE__ |> IO.inspect(), [], [])
    Membrane.Pipeline.play(pid)
    pid
  end

  @impl true
  def handle_init(_) do
    children = [
      pcap: %Membrane.Element.Pcap.Source{path: "big_demo.pcap"},
      rtp: Membrane.Element.RTP.Parser,
      jitter_buffer: %Membrane.Element.RTP.JitterBuffer{slot_count: 10},
      depayloader: Membrane.Element.RTP.H264.Depayloader,
      video_parser: %Membrane.Element.FFmpeg.H264.Parser{framerate: {30, 1}},
      dekoder: Membrane.Element.FFmpeg.H264.Decoder,
      player: Membrane.Element.SDL.Player
    ]

    # Map that describes how we want data to flow
    # https://membraneframework.org/guide/v0.5/pipeline.html#content

    links = [
      link(:pcap)
      |> to(:rtp)
      |> to(:jitter_buffer)
      |> to(:depayloader)
      |> to(:video_parser)
      |> to(:dekoder)
      |> to(:player)
    ]

    spec =
      %ParentSpec{
        children: children,
        links: links
      }
      |> IO.inspect()

    {{:ok, spec: spec}, %{}}
  end
end
