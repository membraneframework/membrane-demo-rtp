defmodule UdpTest do
  use Membrane.Pipeline

  def iex_test do
    {:ok, pid} = Membrane.Pipeline.start_link(__MODULE__ |> IO.inspect(), [], [])
    Membrane.Pipeline.play(pid)
    pid
  end

  @moduledoc """
  Sample Membrane pipeline that will play an `.mp3` file.
  """

  @doc """
  In order to play `.mp3` file we need to read it first.
  In membrane every entry point to data flow is called `Source`. Since we want to play a `file`, we will use `File.Source`.
  Next problem that arises is the fact that we are reading MPEG Layer 3 frames not raw audio. To deal with that we need to use `Filter` called decoder. It takes `.mp3` frames and yields RAW audio data.
  There is one tiny problem here though. Decoder returns `%Raw{format: :s24le}` data, but PortAudio (module that actually talks with the audio driver of your computer) wants `%Raw{format: :s16le, sample_rate: 48000, channels: 2}`.
  That's where `SWResample.Converter` comes into play. It will consume data that doesn't suite our needs and will yield data in format we want.
  """
  @impl true
  def handle_init(_) do
    children = [
      udp: %Membrane.Element.UDP.Source{local_port_no: 5000, local_address: {127, 0, 0, 1}},
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
      link(:udp)
      |> via_in(:input, buffer: [warn_size: 264_600, fail_size: 529_200])
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
