#!/bin/bash
[ $# -ne 2 ] && { echo "Usage: $0 workspace master_root_instance"; exit 1; }
# chenv is defined in navigation_utilities
source /usr/local/athena/techops/coredev/utils/navigation_utilities.sh
chenv $1;
echo "Setting MASTER_ROOT_INSTANCE to ${2^^}1"
export MASTER_ROOT_INSTANCE=${2^^}1
echo "Starting Worker for build $BUILDNAME and database $MASTER_ROOT_INSTANCE"
$ATHENA_HOME/scripts/app/platform/worker.pl --start --nodaemon --config=/home/gsequeira/.worker.conf.${2,,}
