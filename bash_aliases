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

alias l="ls -alh"
alias ll="l"
# long listing, hidden files, reverse sort by timestamp, human readable size
alias lt="ls -larth"

############################################################
## Git
############################################################

alias g="git"
alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff --color"
alias gl="git pull"
alias glr="git pull --rebase"
alias gm="git merge"
alias gmf="git merge --no-ff" # http://mislav.uniqpath.com/2013/02/merge-vs-rebase/
alias gp="git push"
alias gs="git status -sb"
alias ga="git add"
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gh="github"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gi="git config branch.master.remote 'origin'; git config branch.master.merge 'refs/heads/master'"
alias gst="git stash"
alias gstu="git stash --include-untracked"
alias gstp="git stash pop"
alias grp="git remote prune"

if [ `which hub 2> /dev/null` ]; then
  alias git="hub"
fi
alias git-churn="git log --pretty="format:" --name-only | grep -vE '^(vendor/|$)' | sort | uniq -c | sort"

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
    git checkout $*
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
## Git SVN
############################################################

alias gslr="git svn rebase"
alias gsp="git svn dcommit"
alias gsg="git svn log"
alias gsi="git svn info"


############################################################
## Subversion
############################################################

# Remove all .svn folders from directory recursively
alias svn-clean='find . -name .svn -print0 | xargs -0 rm -rf'
# Show my last 50 entries into the svn log
alias svnlog="svn log --limit 100 | grep -B1 -A3 '| cmurphy |'"

############################################################
## Vagrant
############################################################

alias v='vagrant'
alias vs='v ssh'
alias vd='v destroy'
alias vh='v halt'
alias vu='v up'
alias vb='v box'
alias vb='v box'

############################################################
## OS X
############################################################

# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Track who is listening to your iTunes music
alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

# Java home
alias cdjava="cd /system/Library/Frameworks/JavaVM.framework/Versions/1.6/Home"

# Open a man page in TextMate
tman () {
  MANWIDTH=160 MANPAGER='col -bx' man $@ | mate
}

############################################################
## Ruby
############################################################

alias r="rake"
alias rv="rvm list"
alias csd="cap staging deploy"
alias cpd="cap production deploy"

function gemdir {
  echo `rvm gemdir`
}

function gemfind {
  local gems=`gemdir`/gems
  echo `ls $gems | grep -i $1 | sort | tail -1`
}

# Use: gemcd <name>, cd's into your gems directory
# that best matches the name provided.
function gemcd {
  cd `gemdir`/gems/`gemfind $1`
}

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open `gemdir`/doc/`gemfind $1`/rdoc/index.html
}

# Use: rt test_file
# Use: rt test_file:test_name_regex
# Finds a file under test/* and runs it with -n /test_name_regex/
function rt {
  FILE_HINT=`echo $1 | cut -f1 -d:`
  TEST_REGEX=`echo $1 | cut -f2 -d:`
  FILE_PATH=`find test/* -maxdepth 3 -name ${FILE_HINT}_test.rb`
  if [ -z $FILE_PATH ];
    then
    echo Couldn\'t find file for $FILE_HINT
    return
  fi

  if [[ $1 =~ ":" ]];
    then
    echo Running $FILE_PATH -n /$TEST_REGEX/
    ruby -Itest $FILE_PATH -n /$TEST_REGEX/
  else
    echo Running $FILE_PATH
    ruby -Itest $FILE_PATH
  fi
}


############################################################
## Bundler
############################################################
function ignore_vendor_ruby {
  grep -q 'vendor/ruby' .gitignore > /dev/null
  if [[ $? -ne 0 ]]; then
    echo -e "\nvendor/ruby" >> .gitignore
  fi
}

alias b="bundle"
alias bi="b install"
alias bu="b update"
alias be="b exec"
alias bo="b open"
alias biv="bi --path vendor"
alias bil="bi --local"
alias binit="bi && bundle package && ignore_vendor_ruby"

############################################################
## Rails
############################################################

# alias rails="rails -m ~/.rails.d/template.rb"
alias ss="./script/server"
alias sg="./script/generate"
alias sc="./script/console"
alias tl="tail -f log/development.log"

############################################################
## Miscellaneous
############################################################

if [ -f /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
  alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
fi

alias grep='GREP_COLOR="1;37;41" grep --color=auto'
alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"
alias b64="openssl enc -base64"
alias pretty_json="python -mjson.tool" # Usage: echo '{"json":"obj"}' | pretty_json
alias flushdns='dscacheutil -flushcache'
alias whichliniux='uname -a; cat /etc/*release; cat /etc/issue'
alias rm="rm -iv"
alias psg='ps aux|grep '

# make a dir and enter it (or make a set of dirs and enter the last one)
function mcd {
  mkdir -p "${@}" && cd "${1}";
}

# instant web server in current directory
function serve {
  local port=$1
  : ${port:=3000}
  ruby -rwebrick -e"s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd, :MimeTypes => WEBrick::HTTPUtils::load_mime_types('/etc/apache2/mime.types')); trap(%q(INT)) { s.shutdown }; s.start"
}
############################################################
