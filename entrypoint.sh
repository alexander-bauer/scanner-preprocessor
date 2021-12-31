#!/bin/bash -eu

FROM_DIRECTORY=${FROM_DIRECTORY:-/from}
TO_DIRECTORY=${TO_DIRECTORY:-/to}
MATCH=${MATCH:-"*.pdf"}

#TO_OWNER=${}

process_file() {
  from_file="$1"
  to_file="$2"

  echo "Processing $from_file -> $to_file"
  mv "$match" "$to_file"
  chown "$TO_OWNER" "$to_file"
}

echo "Watching $FROM_DIRECTORY for pattern $MATCH; sending to $TO_DIRECTORY with owner $TO_OWNER"

while true; do
  MATCHES=$(find "$FROM_DIRECTORY" -mindepth 1 -maxdepth 1 -name "$MATCH" -type f)
  if [[ ! -z "$MATCHES" ]]; then
    echo "Found matches: $MATCHES"
    for match in "$MATCHES"; do
      to_file="$TO_DIRECTORY/$(basename $match)"
      process_file "$match" "$to_file"
    done
  else
    sleep 5
  fi
done
