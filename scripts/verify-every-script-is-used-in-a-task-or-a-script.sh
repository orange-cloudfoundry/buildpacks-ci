#!/bin/bash -l

SCRIPTS_DIR=${SCRIPTS_DIR:-"scripts"}
TASKS_DIR=${TASKS_DIR:-"tasks"}
EXCLUDE_SCRIPT=${EXCLUDE_SCRIPT:-""}

pushd buildpacks-ci >>/dev/null

  FAIL=false
  for script in $(find $SCRIPTS_DIR -type f)
  do
    echo $EXCLUDE_SCRIPT|grep $script >/dev/null
    FOUND=$?
    if [[ $FOUND -eq 0 ]]; then
        echo "ignoring $script"
        continue
    fi

    ack "$script" $TASKS_DIR >> /dev/null
    # script_is_used "$script"
    EXIT_STATUS=$?
    if [[ $EXIT_STATUS -ne 0 ]]; then
        ack "$script" $SCRIPTS_DIR >> /dev/null
        EXIT_STATUS=$?
        if [[ $EXIT_STATUS -ne 0 ]]; then
          FAIL=true
          echo "$script is not used in any task or script in buildpack-ci"
        fi
    fi
  done

  if $FAIL; then
    exit 1
  fi

popd