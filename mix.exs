defmodule UdpTest.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :udp_test,
      version: @version,
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
      {:membrane_core, "~> 0.5"},
      {:membrane_element_udp, "~> 0.3"},
      {:membrane_element_rtp, "~> 0.3"},
      {:membrane_element_ffmpeg_h264, "~> 0.3"},
      {:membrane_element_file, "~> 0.3"},
      {:membrane_element_rtp_jitter_buffer, "~> 0.2"},
      {:membrane_element_rtp_h264, "~> 0.2"},
      {:membrane_loggers, "~> 0.3"},
      {:membrane_element_sdl, github: "membraneframework/membrane-element-sdl"},
      {:membrane_element_pcap, github: "membraneframework/membrane-element-pcap"},
      {:bundlex, github: "membraneframework/bundlex", override: true},
      {:shmex, github: "membraneframework/shmex", override: true}
    ]
  end
end
