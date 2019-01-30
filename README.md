# UdpTest

ffmpeg -f mp3 -i ~/Projects/SWMansion/membrane_test/sample.mp3 -acodec libmp3lame -ab 128k -ac 2 -ar 44100 -f rtp rtp://127.0.0.1:5000
gst-launch-1.0 audiotestsrc ! lamemp3enc ! rtpmpapay ! udpsink host="127.0.0.1" port=5000
