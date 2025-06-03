#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# Get the parameters
PROJECT="$1"
FILE="$2"
LINE="$3"
COLUMN="$4"

# Start from the file's directory and walk up until we find project.godot
CURRENT_DIR=$(dirname "$FILE")
PROJECT_ROOT=""

while [ "$CURRENT_DIR" != "/" ] && [ "$CURRENT_DIR" != "." ]; do

	if [ -f "$CURRENT_DIR/project.godot" ]; then
		PROJECT_ROOT="$CURRENT_DIR"
		break
	fi

	# Get the parent directory
	PARENT_DIR=$(dirname "$CURRENT_DIR")

	# If we're not making progress, break to avoid infinite loop
	if [ "$PARENT_DIR" = "$CURRENT_DIR" ]; then
		break
	fi

	CURRENT_DIR="$PARENT_DIR"
done

# If no project.godot was found, just use the file's directory
if [ -z "$PROJECT_ROOT" ]; then
	PROJECT_ROOT=$(dirname "$FILE")
fi

SESSION_NAME=$(basename "$PROJECT_ROOT" | tr ' ' '_' | tr -cd '[:alnum:]_-')

# Check if session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null
SESSION_EXISTS=$?

ATTACHED=$(tmux list-sessions -F '#{session_name}:#{session_attached}' 2>/dev/null | grep "^$SESSION_NAME:" | cut -d':' -f2)
TMUX_TTY=$(tmux list-panes -t "$SESSION_NAME" -F '#{pane_active} #{pane_tty}' | awk '$1 == "1" { print $2 }')

if [ "$ATTACHED" = "1" ]; then
	open -a iTerm

	exit 0
fi

# Create session if needed
if [ $SESSION_EXISTS -ne 0 ]; then
	tmux new-session -ds "$SESSION_NAME" -c "$PROJECT_ROOT"
fi

sleep 2

# Send the lvim command
tmux send-keys -t "$SESSION_NAME" "cd \"$PROJECT_ROOT\"" C-m
tmux send-keys -t "$SESSION_NAME" "lvim +${LINE} -c 'call cursor(${LINE}, ${COLUMN})' '${FILE}'" C-m
tmux send-keys -t "$SESSION_NAME" "echo -ne \"\033]1;$SESSION_NAME\007\"" C-m

# Launch iTerm2 and attach to the tmux session
open -a iTerm
sleep 0.5

osascript <<EOF
tell application "iTerm2"
    activate
    try
        tell current window
            set newTab to (create tab with default profile)
            tell newTab's current session
                write text "tmux attach -t '$SESSION_NAME'"
            end tell
        end tell
    on error
        set newWindow to (create window with default profile)
        tell newWindow's current session
            write text "tmux attach -t '$SESSION_NAME'"
        end tell
    end try
end tell
EOF
