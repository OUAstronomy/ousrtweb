#!/bin/bash
_db="/home/jjtobin/public_html/live_img.sh"
_dg="/home/jjtobin/public_html/srt_win.sh"

while [ true ]; do
  /usr/bin/bash ${_db} &
  /usr/bin/bash ${_dg} &
  sleep 5
done
