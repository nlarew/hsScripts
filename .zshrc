################################################################################
#                                  Antigen                                     #
################################################################################
# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh
    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/sudo
    # zgen oh-my-zsh plugins/pyenv


    # bulk load
    zgen loadall <<EOPLUGINS
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-completions
        zsh-users/zsh-history-substring-search
        zsh-users/zsh-syntax-highlighting
        marzocchi/zsh-notify
        tysonwolker/iterm-tab-colors
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # completions
    #zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/agnoster

    # save all to init script
    zgen save
fi

# source $HOME/.antigen/antigen.zsh

# antigen use oh-my-zsh

# antigen bundle git
# antigen bundle git-extras
# antigen bundle osx
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle zsh-users/zsh-completions

# antigen bundle bric3/oh-my-zsh-git
# antigen bundle tysonwolker/iterm-tab-colors
# antigen bundle marzocchi/zsh-notify

# antigen theme agnoster

# antigen bundle zsh-users/zsh-syntax-highlighting
#antigen apply

################################################################################
#                                 ZSH config                                   #
################################################################################

# don't save to zsh history if suffixed with a space
#setopt HIST_IGNORE_SPACE

################################################################################
#                                 ZSH aliases                                  #
################################################################################

alias ci='code-insiders'
alias zshrc='code-insiders ~/.zshrc'
alias sourcezshenv='source ~/.zshenv'
alias dim="python3 ~/nicklarew/projects/docs_issue_manager/main.py"
alias compact='export PS1="$ "'
alias uncompact='export PS1=%{%f%b%k%}$(build_prompt)'



################################################################################
#                                custom functions                              #
################################################################################

# pag: Lists running processes that match the provided pattern
function pag () {
    ps -erv | ag $1'|PID'
}

################################################################################
#                                 misc config                                  #
################################################################################

# default editor
export EDITOR="/usr/local/bin/code-insiders"

## Python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh

# rupa/z - Jump around!
. /usr/local/etc/profile.d/z.sh


# Go
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

#Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

#Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"
PATH=$PATH:/Users/nick/.local/mut/bin:/Users/nick/virtualenvprojects/:/Users/nick/mongodb:/Users/nick/mongodb/codereview

# Pyenv Setup
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
