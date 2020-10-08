# README

## Setup

1. Link the dot files to the home directory

    ```sh
    # Basic install
    ./install.sh

    # Replace old dotfiles in HOME DIR (force link)
    ./install.sh -f

    # Optionally if you want skip anyfile being linked use this
    ./install.sh -i <file1> -i <file2>
    # e.g. ./install.sh -i .gitconfig

    # Install zsh plugins if not already installed
    ./install.sh -z

    # To set the system id use this
    ./install.sh -s <system_id>
    # e.g. ./install.sh -s workbook_mac

    # Link mode for dotfiles
    ./install.sh -m <option>
    # `option` can be
    # c (or) copy       - copy dotfiles to HOME DIR
    # s (or) softlink   - softlink dotfiles to HOME DIR
    # default           - hardlink dotfiles to HOME DIR

    # putting it all together
    ./install.sh -fz -i .gitconfig -s remote-container -m softlink
    ```

1. Verify if dotfiles are linked properly (Optional)

    ```sh
    # Verify if hardlinks are established
    ls -1ad .?*|grep -v -w .git|xargs -I% echo [ % -ef ~/% ]
    ls -1ad .?*|grep -v -w .git|xargs -I% [ % -ef ~/% ]
    ```

## Tools Required

1. zsh

    ```sh
    apt update && apt install -y zsh
    ```

1. Plugins installed by `install.sh`
   1. oh-my-zsh
   1. powerlevel10k
   1. zsh-autosuggestions

### Optional

1. powerline fonts

    ```sh
    apt install fonts-powerline
    ```

    For OSX:
    [SourceCode Pro for Powerline](https://github.com/powerline/fonts/blob/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf)
    [More Info & Instructions](https://gist.github.com/kevin-smets/8568070)

1. Nerd fonts

    ```sh
    brew tap homebrew/cask-fonts
    brew cask install font-meslolg-nerd-font
    brew cask install font-saucecodepro-nerd-font
    ```

1. git
1. conda

    ```sh
    brew cask install anaconda
    ```

1. iterm2

    ```sh
    brew cask install iterm2
    ```

1. ZSH installing from source on user local directory
    https://jdhao.github.io/2018/10/13/centos_zsh_install_use/
    https://medium.com/@ritvikmarwaha/change-your-shell-to-zsh-on-a-remote-server-with-or-without-root-access-c4339804caab

    ```sh
    mkdir -p $HOME/.local
    wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
    mkdir -p zsh
    unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
    cd zsh
    ./configure --prefix="$HOME/.local" CPPFLAGS="-I$HOME/.local/include" LDFLAGS="-L$HOME/.local/lib"
    make -j
    make install
    ```

1. Install ncurses-devel from source (Dependency of zsh)
    https://jdhao.github.io/2018/10/13/centos_zsh_install_use/
    https://unix.stackexchange.com/questions/123597/building-zsh-without-admin-priv-no-terminal-handling-library-found

    ```sh
    wget --no-proxy ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz
    wget --no-proxy ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.2.tar.gz.sig
    gpg ncurses-6.2.tar.gz.sig
    gunzip ncurses-6.2.tar.gz
    tar xf ncurses-6.2.tar
    rm ncurses-6.2.tar
    cd ncurses-6.2

    ./configure --prefix=$HOME/.local CXXFLAGS="-fPIC" CFLAGS="-fPIC"
    make -j
    make install

    cd ..
    rm -rf ncurses-6.2
    ```

## TODO

- [x] User prompt for remote containers
- [x] Options to specify ignore files for hardlinks
- [x] Local system id template and substitution
- [x] Fix exit codes
- [ ] Install fonts
- [ ] Brewfile
- [ ] Dry run option
- [ ] Allow multiple `MY_CUSTOM_SOURCE*` variables to be executed
- [ ] change `target` and `source` already linked verification to support softlinks
- [x] Update README
  - [x] to use `install.sh`
  - [x] to set `localrc.sh` using template
  - [x] install instructions for zsh plugins
