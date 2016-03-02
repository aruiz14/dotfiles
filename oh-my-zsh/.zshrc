# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
if [[ "$OSTYPE" = darwin* ]] ; then
    # ZSH_THEME="clean"
    ZSH_THEME="honukai"
else
    # ZSH_THEME="re5et"
    ZSH_THEME="honukai"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=${ZSH}-custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(common-aliases git autojump colored-man colorize extract zsh-syntax-highlighting tmux fancy-ctrl-z)

if [[ "$OSTYPE" = darwin* ]] ; then
    plugins=($plugins osx brew)
else
    export COMPRESSIONALGORITHM=zip
    export JAVA_HOME="/home/bitrock/java"
    export PATH="/home/bitrock/.autojump/bin:$JAVA_HOME/bin:/home/bitrock/groovy/bin:/home/bitrock/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/arcanist/bin"
    export NODE_PATH="/home/bitrock/harpoon-tests/harpoon2/harpoon_modules/:$NODE_PATH"
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
fi

# User configuration
export TZ=Europe/Madrid
export EDITOR=vim

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias rsync-fast="rsync -HAXxv --numeric-ids --progress -e \"ssh -T -c arcfour -o Compression=no -x\""
fnd () {find . -name "*$1*"}
alias tailf="tail -f -n 0"
grep () {command grep $@ | command grep -v grep}
alias rgrep="grep -r -n --color=always"

# Emacs configuration
if [[ "$OSTYPE" != darwin* ]] ; then
    PATH="/home/bitrock/emacs-24.5/build/bin:$PATH"
fi

_emacsd_is_running () {emacsclient --eval "(progn (ignore))" > /dev/null 2>&1}
_emacsd_start () {
    command emacs --daemon
}
_emacsd_stop () {
    emacsclient --eval "(progn (setq kill-emacs-hook nil) (kill-emacs))"
}
emacsd-start () {
    if ! _emacsd_is_running  ; then
        _emacsd_start
    else
        echo "Emacs daemon already running"
    fi
}
emacsd-stop () {
    if _emacsd_is_running ; then
        _emacsd_stop
    else
        echo "Emacs is not running"
    fi
}
emacsd-restart () {
    if _emacsd_is_running ; then
        _emacsd_stop
        echo "Emacs daemon stopped"
    fi
    _emacsd_start
    echo "Emacs daemon started"
}
emacs () {
    if ! _emacsd_is_running ; then
        _emacsd_start
    fi
    emacsclient -t $@
}
# alias emacs="emacsclient -t"
alias vim="emacs"

# Configuration out of version control
if [ -f ~/.extra.zshrc ] ; then
    source ~/.extra.zshrc
fi

# # 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# # # 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# # # 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# # # 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# # # + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[1;10D' beginning-of-line
bindkey '^[[1;10C' end-of-line


## ANTIGEN ##
source ~/.antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle git