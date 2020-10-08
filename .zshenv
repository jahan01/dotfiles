# echo "sourcing zshenv"
#load system id
[ -r ~/dotfiles/localrc.sh ] && source ~/dotfiles/localrc.sh

#loading paths
[ -r ~/dotfiles/paths.${MY_SYSTEM_ID}.sh ] && source ~/dotfiles/paths.${MY_SYSTEM_ID}.sh

# Load nvm for non-interactive shells.
# To mainly support vscode tasks
# if [[ ! -o interactive ]]; then
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# fi
