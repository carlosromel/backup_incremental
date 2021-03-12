

#!/bin/bash

BASE=/media/backup/backup.rsync
AGORA=$(date +"%Y-%m-%d-%H%M%S")

[ -d "$1" ] && ORIGEM="$1" || ORIGEM=~

mkdir -p ${BASE}/
ANTERIOR=$(ls -d ${BASE}/[[:digit:]][[:digit:]][[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]-[[:digit:]][[:digit:]]-[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]] 2> /dev/null | tail -n 1)
DESTINO=${BASE}/${AGORA}/

if [ -z "${ANTERIOR}" ]; then
    rsync --archive \
          --hard-links \
          --relative \
          --exclude=${BASE} \
          ${ORIGEM} ${DESTINO}
else
    rsync --archive \
          --hard-links \
          --relative \
          --delete \
          --exclude=${BASE} \
          --link-dest=../../${ANTERIOR} \
          ${ORIGEM} ${DESTINO}
fi

( cd ${BASE}/;
  [ -L atual ] && rm atual;
  ln -s ${AGORA} atual )
