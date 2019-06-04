defmodule UdpTest.MixProject do
  use Mix.Project

  def project do
    [
      app: :udp_test,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:membrane_core, "~> 0.3"},
      {:membrane_element_udp, "~> 0.2.0"},
      {:membrane_element_rtp, "~> 0.2.0"},
      {:membrane_element_ffmpeg_h264, "~> 0.1.0"},
      {:membrane_element_file, "~> 0.2.0"},
      {:membrane_element_rtp_jitter_buffer, "~> 0.1.0"},
      {:membrane_element_rtp_h264, "~> 0.1.0"},
      {:membrane_loggers, "~> 0.2.0"},
      {:membrane_element_sdl, github: "membraneframework/membrane-element-sdl"},
      {:membrane_element_pcap, github: "membraneframework/membrane-element-pcap"}
    ]
  end
end
