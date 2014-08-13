# Getting Started

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
    $ ln -ns gemrc   ~/.gemrc
    $ ln -ns autotest.d ~/.autotest.d

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

## Requirements

* *nix environment (e.g. Mac OS X or Linux)
* Bash version >= 3 (for command line enhancements)
* Ruby (for the install.rb to work)
