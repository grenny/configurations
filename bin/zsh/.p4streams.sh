# Set ANet P4 Streams Path
_p4streams() {
	local streamdir=${1:='dev'};
	echo "Switching $streamdir stream.";

	# Set the Perforce client
	export REMOTE_P4_CLIENT=${USER}_streams_${streamdir}
	export REMOTE_P4_HOME=p4/streams/${streamdir}
	export LOCAL_P4_HOME=p4
}
