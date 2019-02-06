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
      player: Membrane.Element.Sdl.Sink
    ]

    links = %{
      {:pcap, :output} => {:rtp, :input},
      {:rtp, :output} => {:jitter_buffer, :input},
      {:jitter_buffer, :output} => {:depayloader, :input},
      {:depayloader, :output} => {:video_parser, :input},
      {:video_parser, :output} => {:dekoder, :input},
      {:dekoder, :output} => {:player, :input}
    }

    spec =
      %Membrane.Pipeline.Spec{
        children: children,
        links: links
      }
      |> IO.inspect()

    {{:ok, spec}, %{}}
  end
end
