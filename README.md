# Getting Started

Clone this (or a forked version of this) repository, and update all the git
submodules within.

    $ cd ~
    $ git clone https://chmurph2@github.com/chmurph2/dotfiles.git .dotfiles
    $ cd .dotfiles
    $ git submodule update --init --recursive

(Option 1) If you'd like to symlink everything within this repository to your
home directory, run `install.rb`

    $ cd ~/.dotfiles
    $ ./install.rb

(Option 2) If you'd like to just symlink one or more configurations to your
home directory manually, you can.

    $ cd ~/.dotfiles
    $ ln -ns gemrc   ~/.gemrc
    $ ln -ns autotest.d ~/.autotest.d


