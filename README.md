# .dotfiles
Dotfiles (e.g. .profile, .gemrc, etc.) are configuration files that personalize your system. These files normally live under your $HOME directory and are hidden, in that they are preceded by a dot (hence "dotfiles") and not shown by default in places like OS X's Finder.app.

These are my dotfiles that are generic enough to share across the computers I use, and with other users.

## Requirements

* *nix environment (e.g. Mac OS X or Linux)
* Bash version >= 3 (for command line enhancements)
* Ruby (for the install.rb to work)

## Getting Started

Clone (or fork) this repository, and update all the git submodules within.

    $ cd ~
    $ git clone git@github.com:chmurph2/dotfiles.git .dotfiles # or wherever you prefer
    $ cd .dotfiles
    $ git submodule update --init --recursive

**(Option 1)** If you'd like to symlink everything within this repository to your
home directory, run `install.rb`.

    $ cd ~/.dotfiles
    $ ./install.rb

**(Option 2)** If you'd like to just symlink one or more configurations to your
home directory manually, you can.

    $ cd ~/.dotfiles
    $ git submodule sync
    $ git submodule update --init --recursive
    $ ln -ns bashrc ~/.bashrc

**(Option 3)** Just look around and pick and choose what you like for your own
  dotfiles.

## Notes

If you'd like to use git and github, be sure to add your own `~/.gitconfig_local` file:

```
[user]
  email = email@example.com
  name = Your Name
[github]
  user = your-github-username
```
