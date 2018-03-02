#!/bin/bash
_db="/home/jjtobin/public_html/shellscripts/live_img.sh"
_dg="/home/jjtobin/public_html/shellscripts/srt_win.sh"
_dp="/home/jjtobin/public_html/shellscripts/python_updator.sh"
_dy="/home/jjtobin/RealTime-Sun/"
while [ true ]; do
  cd "${_dy}"
  /usr/bin/env python rt-sun.py
  cd "$CWD"
  /usr/bin/bash ${_db} &
  /usr/bin/bash ${_dg} &
  /usr/bin/bash ${_dp} &
  sleep 5
done
