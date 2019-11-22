__switch() {
	workspace=$1;
	priorworkspace=$2
	[ $workspace != $priorworkspace ] && {
		echo "Switching workspace back to $priorworkspace from $workspace"
		chenv $priorworkspace
	}
}

rdiff() {
	[ $# -lt 1 ] && { echo "Usage: $0 workspace [user] [client]"; return; }
	priorworkspace=$( echo $FEATURE_P4_HOME | awk 'BEGIN { FS = "-" } {print $2}' )
	workspace=${1:-$priorworkspace};
	[ $workspace != $priorworkspace ] && {
		echo "Switching workspace to $workspace from $priorworkspace"
		chenv $workspace
	}

	user=${2:-$P4CLIENT}
	client=${3:-$user}

	echo "Checking for changelists by $user@$client"
	#depot=$(workspaces | grep $workspace | awk '{$1=$1};1' | awk 'match($0, /\.\.\./) {print substr($0, 0, RSTART-1)}')
	depot=$(workspaces | awk '{$1=$1};1' | awk -F'\\.\\.\\.' '/'$workspace'/{print $1}')
	echo "depot = $depot"

	# Remove changelists that are auto-generated
	changelists=(${(f)"$(p4 changes -u $user -c $client $FEATURE_P4_HOME/... | egrep -v 'anet_features|DONTASSOCIATE' | awk '{print $2}')"})
	echo "changelists = $changelists"
	[[ -z ${changelists} ]] && {
		echo "No changelists in $workspace"
		__switch $workspace $priorworkspace
		return
	}

	# list of files that have changed
	files=()
	for changelist in $changelists
	do
		changefiles=(${(f)"$(p4 files $FEATURE_P4_HOME/...@${changelist},${changelist} | awk -F '#' '{print $1}')"})
		files+=($changefiles)
	done

	# Color choices
	RED="\033[1;31m"
	GREEN="\033[1;32m"
	NOCOLOR="\033[0m"
	# Sort and de-dupe the files
	files=(${(iu)files})
	while :
	do
		for ((i=1; i <= ${#files[@]}; i+=1))
		do
			localfile=${files[$i]//$depot/$FEATURE_P4_HOME/}
			devmainfile=${localfile//$FEATURE_P4_HOME/"$P4_HOME/anet/devmain"}
			tag="(changed)"
			color=$NOCOLOR
			if [[ ! -f ${localfile} ]]
			then
				tag="(deleted)"
				color=$RED
			elif [[ ! -f ${devmainfile} ]]
			then
				tag="(added)"
				color=$GREEN
			fi
			echo "[$i] ${color}${localfile//$FEATURE_P4_HOME/...} $tag ${NOCOLOR}"
		done
		echo "[q] Quit"

		read "choice?Which file would you like to diff [q]? "
		[[ -z $choice || ${choice:l} == 'q' ]] && {
		       	__switch $workspace $priorworkspace
		       	return
		}
		[[ ($choice -lt 1) || ($choice -gt ${#files[@]}) ]] && { echo "Enter a valid number"; continue; }

		changedfile=${files[$choice]//$depot/$FEATURE_P4_HOME/}
		devmainfile=${changedfile/$FEATURE_P4_HOME/"$P4_HOME/anet/devmain"}
		echo "Diffing $changedfile"
		echo "Against $devmainfile"

		[[ ! -f $changedfile && ! -f devmainfile ]] && {
			echo "File was added and deleted. No diff available.";
			continue;
		}
		[[ ! -f $changedfile ]] && { vim $devmainfile; continue }
		[[ -f $devmainfile ]] && { vimdiff $changedfile $devmainfile; continue; }
		vim $changedfile
	done
	__switch $workspace $priorworkspace
	return
}

