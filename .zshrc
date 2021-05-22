# echo "sourcing zshrc"
# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DISABLE_MAGIC_FUNCTIONS=true

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster-custom"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git docker pip zsh-autosuggestions docker-compose gradle-completion
)

# https://github.com/gabrielelana/awesome-terminal-fonts
[ -r ${HOME}/.fonts ] && source ${HOME}/.fonts/*.sh

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh root_indicator dir remote_container status)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs anaconda battery command_execution_time ram time)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(anaconda vcs status command_execution_time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time virtualenv anaconda vcs)
POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
POWERLEVEL9K_VCS_GIT_HOOKS=()
POWERLEVEL9K_SHOW_CHANGESET=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_first_and_last
POWERLEVEL9K_ANACONDA_BACKGROUND=220
POWERLEVEL9K_ANACONDA_SHOW_PYTHON_VERSION=true
typeset -g POWERLEVEL9K_PYTHON_ICON
POWERLEVEL9K_MODE='nerdfont-fontconfig'
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh root_indicator dir)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status anaconda  battery command_execution_time ram time)

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$(${ANACONDA_PATH}/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
    # eval "$__conda_setup"
# else
    if [ -f "${ANACONDA_PATH}/etc/profile.d/conda.sh" ]; then
        . "${ANACONDA_PATH}/etc/profile.d/conda.sh"
    else
        export PATH="${ANACONDA_PATH}/bin:$PATH"
    fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# autoload -Uz compinit && compinit

autoload -U bashcompinit && bashcompinit
# if type "register-python-argcomplete" > /dev/null; then
#     eval "$(register-python-argcomplete pipx)"
# fi

# zprof

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [[ -r "/usr/local/etc/bash_completion.d/cf-cli" ]]; then . "/usr/local/etc/bash_completion.d/cf-cli"; fi

function prompt_remote_container() {
    if [ "$MY_SYSTEM_ID" = "remote-container" ]; then
        p10k segment -f 225 -b 240 -t $MY_SYSTEM_ID
    fi
}

# options for zsh history goes here
# oh-my-zsh sets few history options, so ideally its good to this block after sourcing oh-my-zsh
setopt HIST_IGNORE_ALL_DUPS

# --no-use is set for faster loading. It doesn't activate default node version
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

#always this be the last
if [ -n "$MY_CUSTOM_SOURCE" ]; then
    eval $MY_CUSTOM_SOURCE
    unset MY_CUSTOM_SOURCE
fi
