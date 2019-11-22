# scale_monitor - runs scale monitor against the workspace and database passed in as args.
scale_monitor() { anet scale_monitor $1 $2 }

# switch - switches a workspace to a P4 branch specified in the JIRA-ID
switch() {
	[ $# -ne 2 ] && { echo "Usage: $0 workspace jira-id"; return; }
	jiraid=${2:u};
	[[ $jiraid =~ ^[[:digit:]] ]] && jiraid="ISMS-$jiraid";
	echo "Switching Workspace $1 to $jiraid";
	switch_branch --switch $1 --fromjira $jiraid;
	chenv $1
	syncclient
}

# worker - runs worker against the workspace and database passed in as args.
worker() { anet worker $1 $2 }

# anet - helper method for 'worker' and 'scale_monitor'.
# runs the script passed in as the first arg ($1) against the
# workspace and the database passed in the next two args.
anet() {
	[ $# -ne 3 ] && { echo "Usage: $1 workspace master_root_instance"; return; }
	chenv $2;
	# ${2:u} => uppercase the master_root_instance
	echo "Setting MASTER_ROOT_INSTANCE to ${3:u}1"
	export MASTER_ROOT_INSTANCE=${3:u}1
	echo "Starting ${1:u} for build $BUILDNAME and database $MASTER_ROOT_INSTANCE"
	# ${2:l} => lowercase the master_root_instance
	$ATHENA_HOME/scripts/app/platform/$1.pl --start --nodaemon \
		--config=/home/gsequeira/.$1.conf.${3:l}
}

