#!/bin/bash

platform=$(uname -a)

start_dt=1171864861 # HN did not exist before this.
end_dt=$(date +%s)

# By default, opens 1 page but user can provide arg to open more
n=1
if [[ $# == 1 ]]; then
	n="$1"
	if [[ n -gt 6 ]]; then
		n=6
	fi
fi

for each in $(seq 1 "$n"); do

  if [[ $platform =~ "MAC" ]]; then
    
    rand_dt=$(jot -r 1 "$start_dt" "$end_dt")
    dt=$(date -r "$rand_dt" '+%Y-%m-%d')
    open "https://news.ycombinator.com/front?day=${dt}"

  elif [[ "$platform" =~ "Linux" ]]; then
    
    rand_dt=$(shuf -i "$start_dt"-"$end_dt" -n 1)
    dt=$(date -d "1970-01-01 UTC + \"$rand_dt\" seconds" '+%Y-%m-%d')
    firefox "https://news.ycombinator.com/front?day=${dt}" &>/dev/null &
  
  else
	  echo "I don't know the platform, quitting."
	  exit 1
  fi

  sleep 2
done

