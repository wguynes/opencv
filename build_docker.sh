#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build --rm -t raspbian:8.0 ${SCRIPT_DIR}
