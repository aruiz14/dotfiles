alias rsync-fast="rsync -HAXxv --numeric-ids --progress -e \"ssh -T -c arcfour128 -o Compression=no -x\""
fnd () {find . -name "*$1*"}
alias tailf="tail -f -n 0"
grep () {command grep $@ | command grep -v grep}
alias rgrep="grep -r -n --color=always"

_emacsd_is_running () {emacsclient --eval "(progn (ignore))" > /dev/null 2>&1}
_emacsd_stop () {
    emacsclient --eval "(progn (setq kill-emacs-hook nil) (kill-emacs))"
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
    command emacs --daemon
    echo "Emacs daemon started"
}
emacs () {
    command emacsclient -t --alternate-editor="" $@
}

alias vim="emacs"
alias clip="nc -U ~/.clipper.sock"
