# UdpTest

Tymczasowe źródło danych
```
gst-launch-1.0 -v videotestsrc ! capsfilter caps=video/x-raw,format=I420 \
   ! x264enc \
   ! rtph264pay \
   ! udpsink host="127.0.0.1" port=5000 
```

App launch
```
iex -S mix
> UdpTest.iex_test
```