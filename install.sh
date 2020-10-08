#!/bin/sh

BASE_DIR=$(dirname "$0")
BKP_DIR=$BASE_DIR/bkp
echo "Dotfiles dir: $BASE_DIR"
echo "Backip dir: $BKP_DIR"

linkfiles() {
    filename=$1
    filebasename=$(basename "$filename")
    target=${HOME}/${filebasename}
    if [ ! -z "$COPY_FILES" ]; then
        link_command="cp"
    elif [ ! -z "$SOFTLINK" ]; then
        link_command="ln -s"
    else
        echo "hard linking.."
        link_command="ln"
    fi
    if [ -e "${target}" ]; then
        if [ "${target}" -ef "${filename}" ]; then
            echo "${target} already hardlinked with ${filename}"
        else
            echo "${target} already exists."
            if [ -z "$FORCE_LINK" ]; then
                echo "Not linking files"
            else
                echo "force option is set. Will backup existing file and force link new ones"
                backup $target
                echo "Running... ${link_command} ${filename} ${target}"
                ${link_command} ${filename} ${target}
            fi
        fi
    else
        echo "Running... ${link_command} ${filename} ${target}"
        ${link_command} ${filename} ${target}
    fi

}

backup() {
    sourcefile=$1

    if [ ! -d "$BKP_DIR" ]; then
        echo "Creating $BKP_DIR"
        mkdir $BKP_DIR
        exit_code=$?
        if [ $exit_code -ne 0 ]; then
            echo "Failed creating bkpdir $BKP_DIR"
            exit $exit_code
        fi
    fi
    bkp_date=$(date +%Y%m%d%H%M%S)
    scoped_file_basename=$(basename "$sourcefile")

    if [ "$scoped_file_basename" = ".." ] || [ "$scoped_file_basename" = "." ]; then
        return
    fi

    scoped_filename=${scoped_file_basename%%.*}
    case "$scoped_file_basename" in
        *.*)  file_extension=.${scoped_file_basename#*.} ;;
        *) file_extension='' ;;
    esac

    if [ "$scoped_file_basename" = "$file_extension" ]; then # check if its a dotfile
        scoped_filename=$scoped_file_basename
        file_extension=''
    fi

    bkp_filename=${scoped_filename}.${bkp_date}${file_extension}
    mv $sourcefile $BKP_DIR/$bkp_filename

    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Failed moving $sourcefile to $bkp_file"
        exit $exit_code
    fi

}

install_zsh_plugins() {
    echo "Installing ZSH Plugins ..."
    OMZ=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    [ ! -d "$OMZ" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    [ ! -d "$OMZ/plugins/zsh-autosuggestions" ] && git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${OMZ}/plugins/zsh-autosuggestions
    [ ! -d "$OMZ/themes/powerlevel10k" ] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${OMZ}/themes/powerlevel10k
    [ ! -d "$OMZ/plugins/gradle-completion" ] && git clone --depth=1 https://github.com/gradle/gradle-completion ${OMZ}/plugins/gradle-completion
    echo "Finished installing ZSH Plugins"
}

set_system_id() {
    echo "Setting the system id"
    if [ -f "$BASE_DIR/localrc.sh" ]; then
        echo "WARNING: $BASE_DIR/localrc.sh already exists. So below will just append"
    fi
    sed "s/MY_SYSTEM_ID=xxx/MY_SYSTEM_ID=${SYSTEM_ID}/g" $BASE_DIR/localrc.tmpl.sh >> $BASE_DIR/localrc.sh
}

run() {
    for filename in $(\ls -1Ad ${BASE_DIR}/.?*|grep -v -w .git|grep -v -w .gitignore|grep -v -w .vscode ); do
        file_basename=$(basename $filename)
        if [ "$file_basename" = ".." ] || [ "$file_basename" = "." ]; then
            continue
        fi
        for ignored_file in $IGNORE_FILES; do
            if [ "$file_basename" = "$ignored_file" ]; then
                echo "Ignoring $ignored_file from hardlink"
                continue 2
            fi
        done
        linkfiles $filename
    done

    if [ ! -z "$INSTALL_ZSH_PLUGINS" ]; then
        install_zsh_plugins
    fi

    if [ ! -z "$SYSTEM_ID" ]; then
        set_system_id
    fi
}

IGNORE_FILES=""

# install_zsh_plugins
while getopts "fzs:i:m:" o; do
    case "${o}" in
        f)
            echo "Will force install dotfiles"
            FORCE_LINK=1
            ;;
        z)
            echo "Will install zsh plugins if not already installed"
            INSTALL_ZSH_PLUGINS=1
            ;;
        s)
            SYSTEM_ID=${OPTARG}
            echo "Will be setting the system id to ${SYSTEM_ID}"
            ;;
        i)
            IGNORE_FILES="$IGNORE_FILES ${OPTARG}"
            echo "Will be ignoring files ${IGNORE_FILES} from hardlinks"
            ;;
        m)
            MODE=${OPTARG}
            if [ "$MODE" = "c" ] || [ "$MODE" = "copy" ]; then
                echo "Will be copying the dotfiles to HOME_DIR"
                COPY_FILES=1
            elif [ "$MODE" = "s" ] || [ "$MODE" = "softlink" ]; then
                echo "Will be softlinking the dotfiles to HOME_DIR"
                SOFTLINK=1
            else
                echo "Will be hardlinking the dotfiles to HOME_DIR"
            fi
    esac
done

# allow vscode remote containers to force install as passing options to install script is not supported yet
# VSCODE_REMOTE_CONTAINERS_SESSION: available only during first time container startup
# LOGNAME: Available only after container has started
if [ ! -z "$VSCODE_REMOTE_CONTAINERS_SESSION" ] || [ "$LOGNAME" = "vscode" ]; then
    echo "vscode user Detected: Forcing links and installing plugins"
    FORCE_LINK=1
    INSTALL_ZSH_PLUGINS=1
    SYSTEM_ID=remote-container
    IGNORE_FILES=".gitconfig"
    SOFTLINK=1
    if [ "$LOGNAME" = "vscode" ]; then
        unset SYSTEM_ID
        unset SOFTLINK
        COPY_FILES=1
    fi
fi

if [ "$CODESPACES" = "true" ]; then
    echo "Codespace Detected: Forcing links and installing plugins"
    FORCE_LINK=1
    INSTALL_ZSH_PLUGINS=1
    SYSTEM_ID=codespaces
    IGNORE_FILES=".gitconfig"
    COPY_FILES=1
fi

run
