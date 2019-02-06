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
      {:membrane_core, "~> 0.2.1"},
      {:bunch,
       [env: :prod, git: "https://github.com/membraneframework/bunch.git", override: true]},
      {:membrane_element_udp, github: "membraneframework/membrane-element-udp"},
      {:membrane_element_rtp, github: "membraneframework/membrane-element-rtp"},
      {:membrane_element_ffmpeg_h264, "~> 0.1"},
      {:membrane_element_file, "~> 0.2"},
      {:membrane_element_rtp_jitter_buffer,
       github: "membraneframework/membrane-element-rtp-jitter-buffer",
       branch: "basic-jitter-buffer"},
      {:membrane_element_rtp_h264,
       github: "membraneframework/membrane-element-rtp-h264",
       branch: "depayloading-fu-a-and-stap-a"},
      {:membrane_loggers, git: "git@github.com:membraneframework/membrane-loggers.git"},
      {:membrane_element_sdl,
       github: "membraneframework/membrane-element-sdl", branch: "develop"},
      {:membrane_element_pcap,
       github: "membraneframework/membrane-element-pcap", branch: "basic-source"}
    ]
  end
end
