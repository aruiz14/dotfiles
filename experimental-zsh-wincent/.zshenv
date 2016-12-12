export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

export TZ=Europe/Madrid
export EDITOR=vim

if [[ "$(uname)" = "Linux" && -n "$SSH_TTY" && -d "$HOME/emacs-build/25.1/bin" ]] ; then
    export PATH="$HOME/emacs-build/25.1/bin:$PATH"
fi
