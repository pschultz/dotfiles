#!/bin/bash
function stamp() {
  printf "%s %6d\n" "$(date '+%Y-%m-%d %H:%M:%S')" $$
}

cd $(dirname $0);
BASENAME=$(basename $0);
LOG_FILE="$(pwd)/${BASENAME%sh}log"

{
  TR_USERNAME=""
  TR_PASSWORD=""
  SRC_DIR="${TR_TORRENT_DIR}/${TR_TORRENT_NAME}"
  DEST_DIR="${TR_TORRENT_DIR}/"
  TR_TORRENT_PARAMETER="EXTRACT"

  if [ -e "$SRC_DIR/keep" ]; then
    TR_TORRENT_PARAMETER="$TR_TORRENT_PARAMETER KEEP"
  fi

  if [ -e "$SRC_DIR/skip" ]; then
    TR_TORRENT_PARAMETER="$TR_TORRENT_PARAMETER SKIP"
  fi

  if [[ "$TR_TORRENT_PARAMETER" =~ "SKIP" ]]; then
    echo "$(stamp)" "Skipping $TR_TORRENT_NAME" 
    exit 0
  fi

  if [[ "$TR_TORRENT_PARAMETER" =~ "EXTRACT" ]]; then
    cd $TR_TORRENT_DIR
    if [ -d "$SRC_DIR" ]; then
      IFS=$'\n'
      unset RAR_FILES i
      for RAR_FILE in $( find "$SRC_DIR" -iname "*.rar" ); do
        if [[ $RAR_FILE =~ .*part.*.rar ]]; then
          if [[ $RAR_FILE =~ .*part0*1.rar ]]; then
            RAR_FILES[i++]=$RAR_FILE
          fi
        else
          RAR_FILES[i++]=$RAR_FILE
        fi
      done
      unset IFS

      if [ ${#RAR_FILES} -gt 0 ]; then
        for RAR_FILE in "${RAR_FILES[@]}"; do
          echo "$(stamp)" "Extracting ${RAR_FILE} into ${DEST_DIR}"
          unrar x -inul "$RAR_FILE" "$DEST_DIR"
          if [ $? -gt 0 ]; then
            echo "$(stamp)" "Error extracting $TR_TORRENT_NAME" 
            transmission-remote -n $TR_USERNAME:$TR_PASSWORD -t$TR_TORRENT_ID --verify --start
            exit 0
          fi
        done
        if [[ ! "$TR_TORRENT_PARAMETER" =~ "KEEP" ]]; then
          SLEEP=$(expr match "$TR_TORRENT_PARAMETER" '.*SLEEP\([0-9a-zA-Z]*\)')
          if [ ${#SLEEP} -gt 0 ]; then
            sleep $SLEEP
          fi
          echo "$(stamp)" "Removing and trashing $TR_TORRENT_NAME" 
          transmission-remote -n $TR_USERNAME:$TR_PASSWORD -t$TR_TORRENT_ID --remove-and-delete
        fi
        echo "$(stamp)" "Extracted $TR_TORRENT_NAME"
      fi
    fi
  fi
} >> "${LOG_FILE}" &

# vim: set sts=2 sw=2 expandtab:
