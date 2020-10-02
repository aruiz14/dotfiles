alias rsync-fast="rsync -HAXxv --numeric-ids --progress -e \"ssh -T -c arcfour128 -o Compression=no -x\""
fnd () {find ${2-.} -iname "*$1*"}
alias tailf="tail -f -n 0"
unalias grep
grep () {
    command grep --color=always "$@" | command grep -v grep
}
alias rgrep="grep -r -n"

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
    local p
    p=`env echo $PATH`
    PATH="$p" TERM=xterm-24bits command emacs --daemon
    echo "Emacs daemon started"
}
emacs () {
    local p
    p=`env echo $PATH`
    # KONSOLE_DBUS_SESSION enables TrueColor support
    # https://gist.githubusercontent.com/bsuh/bab7eeb8bda2421ac01c760c90668100/raw/bf8da47cba044249fe75ef1f6a1c78e208ef0e19/gistfile1.diff
    PATH="$p" TERM=xterm-24bits emacsclient -t --alternate-editor="" $@
}

upgrade_go () {
    (
        cd "${HOME}"
        local v=${1:?a valid version must be provided}
        local dest=".go-versions/go-${v}"

        local os
        os=$(uname -s | tr '[:upper:]' '[:lower:]')
        local url="https://dl.google.com/go/go${v}.${os}-amd64.tar.gz"

        mkdir -p "${dest}"
        cd "${dest}"
        curl -SsL "${url}" | tar zx --strip-components 1 -C .
        cd -

        unlink go-runtime || true
        ln -s "${dest}" go-runtime
        go version
    )
}

alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"
alias clip="nc -U ~/.clipper.sock -w0"

# Timestamp
timestamp() {
    while IFS= read -r line; do printf '[%s] %s\n' "$(date '+%H:%M:%S')" "$line"; done
}
alias -g TS="|timestamp"
alias date_gofmt="date -u +%Y-%m-%dT%H:%M:%SZ"

alias kubecfgsort="yq -y -s 'sort_by(\"\(.kind)/\(.metadata.name)\")| .[]'"
