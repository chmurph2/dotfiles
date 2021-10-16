## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

function conditionally_prefix_path {
  local dir=$1
  if [ -d $dir ]; then
    PATH="$dir:${PATH}"
  fi
}

conditionally_prefix_path /opt/homebrew/bin
conditionally_prefix_path /usr/local/bin
conditionally_prefix_path /usr/local/sbin
conditionally_prefix_path /usr/local/share/npm/bin
conditionally_prefix_path /usr/texbin
conditionally_prefix_path /usr/local/heroku/bin:$PATH
conditionally_prefix_path ~/bin
conditionally_prefix_path ~/bin/private

# Prioritize any executables in `./bin`, but de-prioritize any executables in `.`
# to avoid problems installing Rubies 2.7+
PATH=./bin:${PATH}:.

############################################################
## MANPATH
############################################################

function conditionally_prefix_manpath {
  local dir=$1
  if [ -d $dir ]; then
    MANPATH="$dir:${MANPATH}"
  fi
}

conditionally_prefix_manpath /usr/local/man
conditionally_prefix_manpath ~/man

############################################################
## General development configurations
###########################################################

# rbenv: Enable shims and autocompletion:
if [ `which rbenv 2> /dev/null` ]; then
  eval "$(rbenv init -)"
fi

# nodenv
if [ `which nodenv 2> /dev/null` ]; then
  eval "$(nodenv init -)"
fi

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac

# Show the git branch and dirty state in the prompt.
# Stolen from @rmm5t
function parse_git_dirty {
  [[ -n $(git status -s 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

if [ `which git 2> /dev/null` ]; then
  function git_prompt {
    echo $(parse_git_branch)$(parse_git_dirty)
  }
else
  function git_prompt {
    echo ""
  }
fi

if [ `which rbenv 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(rbenv version-name)
  }
elif [ `which ruby 2> /dev/null` ]; then
  function ruby_prompt {
    echo $(ruby --version | cut -d' ' -f2)
  }
else
  function ruby_prompt {
    echo ""
  }
fi

if [ `which rbenv-gemset 2> /dev/null` ]; then
  function gemset_prompt {
    local gemset=$(rbenv gemset active 2> /dev/null)
    if [ $gemset ]; then
      echo " ${gemset}"
    fi
  }
else
  function gemset_prompt {
    echo ""
  }
fi

if [ -n "$BASH" ]; then
  export PS1='\[\033[32m\]\n[\s: \w] ($(ruby_prompt)$(gemset_prompt)) $(git_prompt)\n\[\033[36m\][\u@\h \t]∴ \[\033[00m\]'
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export EDITOR="vi"
export LANG="en_US.UTF-8"

############################################################
## History
############################################################

export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes (I don't like this behavior, actually)
###export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# By default up/down are bound to previous-history and next-history
# respectively. The following does the same but gives the extra functionality
# where if you type any text (or more accurately, if there is any text between
# the start of the line and the cursor), the subset of the history starting with
# that text is searched.
case "$-" in *i*) # use bind command in interactive shell only
  bind '"\e[A"':history-search-backward
  bind '"\e[B"':history-search-forward
esac

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi

############################################################
## Bash Completion, if available
############################################################

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
elif [ -e ~/.bash_completion ]; then
  # Fallback. This should be sourced by the above scripts.
  . ~/.bash_completion
fi

############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

# MacPorts OpenSSL doesn't have a ca bundle, so piggy back on Curl's
# if [ -f /opt/local/share/curl/curl-ca-bundle.crt ] ; then
#   export SSL_CERT_FILE="/opt/local/share/curl/curl-ca-bundle.crt"
# fi

############################################################
## Ruby Performance Boost (see https://gist.github.com/1688857)
############################################################

export RUBY_GC_MALLOC_LIMIT=60000000
export RUBY_FREE_MIN=200000 # Ruby <= 2.0
export RUBY_GC_HEAP_FREE_SLOTS=200000 # Ruby >= 2.1


