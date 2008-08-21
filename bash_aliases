# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

############################################################
## List
############################################################

if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi

alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"

############################################################
## Git
############################################################

alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias ga="git add"

# Useful report of what has been committed locally but not yet pushed to another
# branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $1
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}

############################################################
## Ditz
############################################################

alias d='ditz todo'
alias da='ditz add'
alias ds='ditz show '
alias dst='ditz status '
alias dc='ditz close '
alias de='ditz edit '

############################################################
## Subversion
############################################################

# Remove all .svn folders from directory recursively
alias svn-clean='find . -name .svn -print0 | xargs -0 rm -rf'

############################################################
## OS X
############################################################

# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Track who is listening to your iTunes music
alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

# Java 1.5 home
alias cdjava="cd /system/Library/Frameworks/JavaVM.framework/Versions/1.5/Home"

############################################################
## Ruby
############################################################

alias a="autotest -f"
alias smp="staticmatic preview ."
alias gem="sudo gem"

export GEMS=/opt/local/lib/ruby/gems/1.8/gems
function findgem {
  echo `ls $GEMS | grep -i $1 | sort | tail -1`
}

# Use: cdgem <name>, cd's into your gems directory
# that best matches the name provided.
function cdgem {
  cd $GEMS/`findgem $1`
}

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open $GEMS/../doc/`findgem $1`/rdoc/index.html
}

############################################################
## Rails
############################################################

alias ss="script/server"
alias sg="script/generate"
alias sc="script/console"
alias sd="script/dbconsole"
alias rr="touch /tmp/restart.txt" # restart all passenger-controller Rails apps

############################################################
## Tomcat
############################################################
# alias startt="sudo /opt/local/var/macports/software/tomcat5/5.5.25_0/opt/local/share/java/tomcat5/bin/startup.sh"
# alias stopt="sudo /opt/local/var/macports/software/tomcat5/5.5.25_0/opt/local/share/java/tomcat5/bin/shutdown.sh"
alias startt="sudo /opt/tomcat/bin/startup.sh"
alias stopt="sudo /opt/tomcat/bin/shutdown.sh"


############################################################
## Miscellaneous
############################################################

alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias qs-bounce="osascript ~/Library/Scripts/qs-bounce.scpt"
alias rm="rm -iv"
alias ps="sudo ps -eac"
alias zip="myzip -r"
#SVN: show my last 50 entries into the svn log
alias svnlog="svn log --limit 100 | grep -B1 -A3 '| cmurphy |'"
############################################################
