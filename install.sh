#!/usr/bin/env bash

# set color
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
reset=`tput sgr0`

banner(){
    cat <<EOF


${cyan}#############################
# Love Neo Vim
#############################

${reset}Love-Neo-Vim(LNV) is a out of box vim configuration script based on NeoVim(${yellow}https://github.com/neovim/neovim${reset}). This script will build your NeoVim to as a Semi-IDE for C/C++, Golang, Javascript, Java, HTML5, CSS, etc.

${white}Becasue of using homebrew this script can only run on Unix-like system such like MacOS/Ubuntu etc.${reset}


EOF
}
banner

###############
# check system
###############
quiet_mode=false
homebrew=''

if [ -n $1 ] && [ "$1" == "-q" ]; then
    quiet_mode=true
fi

case "${OSTYPE}" in
    solairs*)
        homebrew="http://linuxbrew.sh/"
        ;;
    darwin*)
        homebrew="http://brew.sh/"
        ;;
    linux*)
        homebrew="http://linuxbrew.sh/"
        ;;
    *)
        echo "Your system is ${white}${OSTYPE}${reset}. This script dependant on homebrew which are only run on MacOS/OSX or Unix-like system. "
        exit 0
esac

# check command exist
command_exists () {
    type "$1" &> /dev/null ;
}

if ! command_exists brew ; then
    echo "This NeoVim configure dependant on homebrew."
    echo "Get more information at ${homebrew}."
    exit 0
fi

######################
# install dependance
#######################
# npm packages
need_npm=false
if ! command_exists npm ; then
    if ${quiet_mode} ; then
        need_npm=true
    else
        echo "Some plugins need nodejs packages but can not find 'npm' to install them."
        echo "n-installer is a good way to install and manage nodejs version."
        echo "You can get more information at https://github.com/tj/n."
        read -n1 -ep "Do you want to install nodejs automaticly with n-installer? [(y)/n]: " reply
        echo ""
        if [ "${reply}" == 'y' ] || [ -z ${reply} ]; then
            need_npm=true
        else
            echo "Please install nodejs by yourself!"
            echo "Bye!"
            exit 0
        fi
    fi
fi

install_node_dep (){
    if ${need_npm} ; then
        if ! command_exists curl ; then
            brew install curl
        fi
    curl -L https://git.io/n-install | bash
    npm i -g npm
    fi
    npm i -g typescript tern
}

# golang
need_golang=false
if ! command_exists go; then
    if ${quiet_mode} ; then
        need_golang=true
    else
        echo "Some plugins need golang environment."
        read -n1 -ep "Do you want to install golang automaticly? [(y)/n]: " reply
        echo ""
        if [ "${reply}" == 'y' ] || [ -z ${reply} ]; then
            need_golang=true
        else
            echo "Please install golang by yourself!"
            echo "Bye!"
            exit 0
        fi
    fi
fi
install_golang (){
    if ${need_golang} ; then
        brew install go
        shell=`ps -p $$ -ocomm= `
        case $shell in
            bash)
                mkdir -p $HOME/.go/bin
                mkdir -p $HOME/.go/src
                mkdir -p $HOME/.go/pkg
                echo ""
                echo "# golang" >> $HOME/.bash_profile
                echo "export GOPATH=$HOME/.go" >> $HOME/.bash_profile
                echo "export PATH=$HOME/.go/bin:$PATH" >> $HOME/.bash_profile
                echo "Golang is installer for you. 'GOPAHT' is $HOME/.go"
                ;;
            -zsh)
                mkdir -p $HOME/.go/bin
                mkdir -p $HOME/.go/src
                mkdir -p $HOME/.go/pkg
                echo ""
                echo "# golang" >> $HOME/.zshrc
                echo "export GOPATH=$HOME/.go" >> $HOME/.zshrc
                echo "export PATH=$HOME/.go/bin:$PATH" >> $HOME/.zshrc
                echo "Golang is installer for you. 'GOPAHT' is $HOME/.go"
                ;;
            *)
                echo "You shell is $shell. I can't configure golang environment for you."
                echo "Use 'brew info go' to see detial."
                exit 0
        esac
    fi
}

# python
if ! command_exists python3 ; then
    echo "NeoVim need python3 neovim package but I can't find python3 environment."
    echo "This is not a fatal error. Install will continue."
fi
install_py_dep (){
    tool_pip=false
    if command_exists pip ; then
        pip install -U neovim
        pip install -U jedi pep8 flake8
        tool_pip=true
    fi

    if command_exists pip2 ; then
        pip2 install -U neovim
        pip3 install -U jedi pep8 flake8
        tool_pip=true
    fi

    if command_exists pip3 ; then
        pip3 install -U neovim
        pip3 install -U jedi pep8 flake8
        tool_pip=true
    fi

    if ! ${tool_pip} ; then
        echo "Can't find python pip."
        echo "You need install python package by yourself with:"
        echo "pip install neovim jedi pep8 flake8"
    fi
}

# ruby
install_ruby(){
    if command_exists gem ; then
        gem install neovim
    else
        echo "Can't find ruby gem."
        echo "You need install neovim package by yourself."
        echo "gem install neovim"
    fi
}

# ect.
install_dep(){
    install_node_dep
    install_golang
    install_py_dep

    if ! command_exists fzf ; then
        brew install fzf
    fi

    if ! command_exists ctags; then
        brew install ctags
    fi
}

####################
# clone init.vim
##################
read -ep "set your neovim root:(~/.nvim) " nv_root
if [ -z ${nv_root} ]; then
    nv_root="$HOME/.nvim"
fi
git clone https://github.com/TsumiNa/.config ${nv_root}
git clone https://github.com/Shougo/dein.vim ${nv_root}/dein/repos/github.com/Shougo/dein.vim
install_dep



