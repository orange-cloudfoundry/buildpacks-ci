#!/bin/bash -l

PIPELINE_DIR=${PIPELINE_DIR:-"pipelines"}
TASKS_DIR=${TASKS_DIR:-"tasks"}
EXCLUDE_TASK=${EXCLUDE_TASK:-""}

#set -x
pushd buildpacks-ci >>/dev/null

  FAIL=false
  for task in $(find $TASKS_DIR -type f -name "*.yml")
  do
    echo $EXCLUDE_TASK|grep $task >/dev/null
    FOUND=$?
    if [[ $FOUND -eq 0 ]]; then
        echo "ignoring $task"
        continue
    fi

    ack "$task" $PIPELINE_DIR >> /dev/null
    EXIT_STATUS=$?
    if [[ $EXIT_STATUS -ne 0 ]]; then
      FAIL=true
      echo "$task is not used in any pipeline in buildpack-ci"
    fi
  done

  if $FAIL; then
    exit 1
  fi

popd