export EDITOR="vim"

export MANPAGER="less -X"

export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

PATH=$PATH:/Users/$USER/Library/Python/2.7/bin:/Applications/MacVim.app/Contents/bin

source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

## Powerline Stuff
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /Users/$USER/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh


function docker_compose_helper() {
  service=$1
  shift
  action=$@

  dcyml="${HOME}/development/${service}/docker-compose.yml"

  if [ ! -f "$dcyml" ]; then
    echo "Can't find docker-compose.yml file for ${service} -- $dcyml"
    return
  fi

  docker-compose -f $dcyml $action
}

function parse_jwt() {
  local token=$1
  local payload=`echo $token | cut -d '.' -f 2`
  local len="${#payload}"
  local mod=$((len % 4))

  if [[ $mod -gt 0 ]]; then
    local pad=$((4 - mod))
    local padding=`echo '======' | cut -c 1,$pad`
    local payload="${payload}${padding}"
  fi 
  echo "$payload"
  echo $payload | base64 --decode | jq '.'
}

# z beats cd most of the time. `brew install z`
zpath="$(brew --prefix)/etc/profile.d/z.sh"
[ -s $zpath ] && source $zpath

## Aliases
alias ll="ls -l"
alias json_pretty="python -m json.tool"
alias godev="cd ~/development"
alias dc="docker_compose_helper"
alias jwt="parse_jwt"
alias prov="~/development/bin/odreadprov.sh"

###
# time to upgrade `ls`

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls='gls -Fh ${colorflag} --group-directories-first'
alias lsd='ls -l | grep "^d"' # only directories
#    `la` defined in .functions
###


# here's LS_COLORS
# github.com/trapd00r/LS_COLORS
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
eval "$(gdircolors -b ~/.dircolors)"
