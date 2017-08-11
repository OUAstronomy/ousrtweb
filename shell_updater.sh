#!/bin/bash
_db="/home/jjtobin/public_html/live_img.sh"
_dg="/home/jjtobin/public_html/srt_win.sh"
_dp="/home/jjtobin/public_html/python_updator.sh"
while [ true ]; do
  /usr/bin/bash ${_db} &
  /usr/bin/bash ${_dg} &
  /usr/bin/bash ${_dp} &
  sleep 5
done
