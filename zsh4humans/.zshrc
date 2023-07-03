# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
# zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return
mkdir -p "$ZSH_CACHE_DIR/completions"

z4h install b4b4r07/enhancd || return
# z4h install junegunn/fzf || return
# zstyle ':z4h:*' fzf-command fzf

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

autoload -Uz is-at-least # Fix for common-aliases plugin

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
oh_my_zsh_libs=(
    directories
    # key-bindings
    compfix
)
for p in $oh_my_zsh_libs[*]; do
    z4h source ohmyzsh/ohmyzsh/lib/${p}.zsh
done
oh_my_zsh_plugins=(
      # Navigation
      # autojump
      # zsh-navigation-tool
      # Others
      colored-man-pages colorize jsontools docker docker-compose kubectl
      # tmux
      # Aliases
      common-aliases extract git git-extras
)
for p in $oh_my_zsh_plugins[*]; do
    z4h source ohmyzsh/ohmyzsh/plugins/${p}/${p}.plugin.zsh
done
z4h source b4b4r07/enhancd/init.sh
# z4h source junegunn/fzf/shell/key-bindings.zsh

# Define key bindings.
z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

# z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
# z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
# z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
# z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md
# Auto-completion from mid-words
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

z4h source ~/.profile
z4h source ~/.extra.zshrc
z4h source ~/.zsh/{exports,aliases,functions}

# Is this needed?
if false ; then
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
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
z4h source "${SDKMAN_DIR}/bin/sdkman-init.sh"

autoload -U add-zsh-hook
add-zsh-hook precmd bounce

POSTEDIT=$'\n\n\e[2A'
