#!/bin/bash

OUTPUT_EXECUTOR_LOGS_TO_STDOUT=${OUTPUT_EXECUTOR_LOGS_TO_STDOUT:=false}
if [[ "${OUTPUT_EXECUTOR_LOGS_TO_STDOUT}" == true ]] ; then
  MONITORDIR="/spark/work/"
  mkdir -p ${MONITORDIR}
  inotifywait -m -r -e create --format '%w%f' "${MONITORDIR}" | while read NEWFILE
  do
    echo "Watching log file: ${NEWFILE}"
    if [[ "${NEWFILE}" =~ .*std(out|err)$ ]]; then
      tail -f ${NEWFILE} &
    fi
  done
fi
