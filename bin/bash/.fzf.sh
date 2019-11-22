#!/bin/zsh
# fd - cd to selected directory
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' \
		-prune -o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

# fif - find-in-file using ripgrep
fif() {
	[ ! "$#" -ge 1 ] && { echo "Usage: fif <string>"; exit 1; }
	rg --files-with-matches --no-messages "$1" | \
		fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# ftpane - switch pane (@george-b)
tpane() {
	local panes current_window current_pane target target_window target_pane
	panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
	current_pane=$(tmux display-message -p '#I:#P')
	current_window=$(tmux display-message -p '#I')
	target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) ||
		return target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
	target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

	if [[ $current_window -eq $target_window ]]; then
		tmux select-pane -t ${target_window}.${target_pane}
	else
		tmux select-pane -t ${target_window}.${target_pane} &&
			tmux select-window -t $target_window
	fi
}

# tm - switch to existing tmux session
tm() {
	[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"

	if [ $1 ]; then
		tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
	fi
	session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&
		tmux $change -t "$session" || echo "No sessions found."
}

# vg - fuzzy grep open via ag with line number
vg() {
	local file
	local line

	read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"
       	if [[ -n $file ]]; then
		vim $file +$line
	fi
}

