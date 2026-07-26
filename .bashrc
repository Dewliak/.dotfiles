# System-wide settings
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# User binaries
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Load modular bash configuration
if [ -d "$HOME/.bashrc.d" ]; then
    for rc in "$HOME/.bashrc.d"/*; do
        if [ -f "$rc" ]; then
            source "$rc"
        fi
    done
fi

unset rc
