# Path to zplug installation.
export ZPLUG_HOME=$HOME/.zplug

# First time clone
if [[ ! -d $ZPLUG_HOME ]]; then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
    source $ZPLUG_HOME/init.zsh && zplug update --self
else
    source $ZPLUG_HOME/init.zsh
fi

autoload -Uz is-at-least # Fix for common-aliases plugin

# Features from oh-my-zsh
oh_my_zsh_libs=(
    directories
    key-bindings
)
for p in $oh_my_zsh_libs; do
    zplug "lib/$p", from:oh-my-zsh
done

# Plugins from oh-my-zsh
# oh_my_zsh_plugins=(autojump common-aliases git colored-man-pages colorize extract tmux fancy-ctrl-z jsontools docker-compose compleat sudo zsh-navigation-tool)
oh_my_zsh_plugins=(
    # Navigation
    # autojump
    zsh-navigation-tool
    # Others
    colored-man-pages colorize emoji jsontools tmux yarn kubectl
    # Aliases
    common-aliases docker-compose extract git git-extras
)
if [[ "$OSTYPE" = darwin* ]] ; then
    plugins=($plugins osx brew brew-cask)
fi
for p in $oh_my_zsh_plugins; do
    zplug "plugins/$p", from:oh-my-zsh
done

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", nice:12

zplug "djui/alias-tips", nice:11

export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HYPHEN=1
zplug "b4b4r07/enhancd", use:init.sh

zplug "supercrabtree/k"
# zplug "unixorn/tumult.plugin.zsh" # OSX tips
# zplug "unixorn/rake-completion.zshplugin"
# zplug "RobSis/zsh-completion-generator"
zplug "srijanshetty/docker-zsh"
zplug "peterhurford/git-it-on.zsh"

zplug "stedolan/jq", \
      from:gh-r, \
      as:command, \
      rename-to:jq

zplug "junegunn/fzf-bin", \
      from:gh-r, \
      as:command, \
      rename-to:fzf
zplug "junegunn/fzf", as:command, \
      use:"bin/fzf-tmux"
zplug "junegunn/fzf", use:shell/key-bindings.zsh, \
      on:"junegunn/fzf-bin", nice:12

zplug "b4b4r07/emoji-cli", \
      on:"stedolan/jq"

zplug "jhawthorn/fzy", \
      as:command, \
      hook-build:"make"

fpath=($HOME/.zsh/completions $fpath) # This has to load before zplug load:w
zplug "~/.zshrc-wincent", from:local, nice:11

# zplug "oskarkrawczyk/honukai-iterm-zsh", nice:15 # needs to be loaded after oh-my-zsh


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# HISTSIZE=10000

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

if [[ "$OSTYPE" != darwin* ]] ; then
    if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;
fi

# Configuration out of version control
if [ -f ~/.extra.zshrc ] ; then
    source ~/.extra.zshrc
fi

# Load aliases
if [ -f $HOME/.aliases.sh ] ; then
    source $HOME/.aliases.sh
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
