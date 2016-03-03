# Configuration files repository

Use `--recursive` option when cloning this repository:
```
git clone --recursive https://github.com/aruiz14/dotfiles
```

After installingGNU Stow (`brew install stow` on OS X or `apt-get install stow` on Debian based systems), get into the `dotfiles` folder and execute `stow <folder>` to load it.

NOTE: The existing configuration files should be previously backed up and removed. Otherwise it will fail to load the configuration.

## Contents
  - Shell: zsh configuration on top of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
  - tmux: including some basic configuration and [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (disabled by default)
  - Editors:
    - Vim configuration based on [janus](https://github.com/carlhuda/janus) distribution.
    - Emacs configured with Vim-like bindings thanks to [evil](https://bitbucket.org/lyro/evil) mode and based on [spacemacs](https://github.com/syl20bnr/spacemacs) distribution.
