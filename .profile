# echo "sourcing .profile"
#load system id
[ -r ~/dotfiles/localrc.sh ] && source ~/dotfiles/localrc.sh

#load system specfic profile
[ -r ~/dotfiles/profile.${MY_SYSTEM_ID}.sh ] && source ~/dotfiles/profile.${MY_SYSTEM_ID}.sh

#load aliases
[ -r ~/dotfiles/aliases.common.sh ] && source ~/dotfiles/aliases.common.sh
[ -r ~/dotfiles/aliases.${MY_SYSTEM_ID}.sh ] && source ~/dotfiles/aliases.${MY_SYSTEM_ID}.sh
