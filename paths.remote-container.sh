# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# MOUNT_PATH_FOR_HOST_PERSISTENCE=/mount_path_for_host
# mkdir -p ${MOUNT_PATH_FOR_HOST_PERSISTENCE}/shell
# HISTFILE=${MOUNT_PATH_FOR_HOST_PERSISTENCE}/shell/.zsh_history
