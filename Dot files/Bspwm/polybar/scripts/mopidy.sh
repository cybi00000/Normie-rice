#!/bin/sh
# Queries the mopidy API for artist and title
#
# requires curl and jq
# place this script in `~/.config/polybar/scripts/mopidy.sh
#
#

set -e
set -o pipefail

MOPIDY_SERVER=${MOPIDY_SERVER:-"http://localhost:6680"}

main() {
  RETURN=$(curl --silent -f -XPOST $MOPIDY_SERVER/mopidy/rpc)

  POSTDATA='{"jsonrpc": "2.0", "id": 1, "method": "core.playback.get_current_track"}'
  DATA=$(curl --silent -d "${POSTDATA}" $MOPIDY_SERVER/mopidy/rpc)

  ARTIST=$(echo $DATA | jq '.result.artists[0].name')
  ALBUM=$(echo $DATA | jq '.result.album.name')
  TITLE=$(echo $DATA | jq '.result.name')

  echo "$ARTIST - $TITLE" | sed s/\"//g | sed s/null\\s-.*//
}

main "$@"
