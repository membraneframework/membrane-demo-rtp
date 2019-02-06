# Video RTP Demo

This repository contains proof of concept demo of Membrane Framework RTP H264 Video support.

### Prerequisites

- git lfs
- libavcodec-dev
- SDL 1.2, it is probably already installed on your machine.

### Using `.pcap` file

Run `iex -S mix` while in this project root folder

```elixir
iex(1)> PcapTest.iex_test
```

### Using GStreamer as Video source

Run `iex -S mix` while in this project root folder

```elixir
iex(1)> UdpTest.iex_test
```

Then start data source, for example GStreamer

```bash
gst-launch-1.0 -v videotestsrc ! capsfilter caps=video/x-raw,format=I420 \
   ! x264enc \
   ! rtph264pay \
   ! udpsink host="127.0.0.1" port=5000

```

If you want to create your own data source, keep in mind that video must be in I420 format.