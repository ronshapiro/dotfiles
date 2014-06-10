# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    battery
    brew
    coffee
    # colored-man
    git
    gitfast
    gradle
    # grails
    heroku
    # mvn
    node
    nosetests
    npm
    osx
    pip
    ruby
    supervisor
    vagrant
    # virtualenv
    # virtualenvwrapper
)

source $ZSH/oh-my-zsh.sh #is this necessary?
export EDITOR="emacs"
alias albus="cd ~/code/open-source/albus/android"
alias e="emacs"
alias ec="emacsclient"
alias es="emacs --daemon"
ef(){
    emacs `ffind $@`
}
alias efs="ef src"
alias epoch="date +%s"
alias v="vim"
alias .vimrc="vim ~/.vimrc"
[[ $EMACS = t ]] && unsetopt zle # enable zsh inside eshell
alias reload_zsh="source ~/.zshrc"
alias .reload_zsh=reload_zsh
alias .zshrc="$EDITOR ~/.zshrc"
# export ANDROID_HOME=~/code/android-sdk
export ANDROID_HOME="/usr/local/opt/android-sdk"
source $HOME/.dotfiles/android-aliases.sh
alias aliases="alias -p" #print all aliases
alias .tmux="$EDITOR ~/.tmux.conf"
alias ackl="ack -i --literal"
alias .emacs="$EDITOR ~/.emacs.d/init.el"
alias ls="ls -G"
alias mkdir="mkdir -p" #create intermediate path for directory
alias untar="tar -zxvf"
alias pt="ps -e -o pid,command | grep"
export LSCOLORS="Bx"
export LESS="-X --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS"
export ACKRC=".ackrc" #allow directory specific .ackrc files
export GREP_OPTIONS='-I --exclude=*.pyc --exclude-dir=.git'
alias grepr="grep -R"
###How to add ssh without a password:
#`scp ~/.ssh/id_rsa.pub USER@HOST:~/.ssh/authorized_keys2`
#you might need to do `chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys2` too
alias mcoder="mencoder mf://pngs/*.png -mf fps=50 -ovc lavc -lavcopts vcodec=msmpeg4v2 -oac copy -o recording.avi"
alias saveToICloud="defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool" # use this alias followed by true/false
ffind () {
    dir="."
    regexp="$1"
    if (( $# == 2 )); then
        dir="$1"
        regexp="$2"
    fi
    find $dir | grep --color $regexp
}
alias .dotfiles="cd ~/.dotfiles"
alias .code="cd ~/code/"
alias gc="git commit"
alias gca="git commit -a"
alias gg="git grep --ignore-case" #make sure to do this within home git dir
alias gcam="git commit -am"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdh="git diff HEAD"
alias gds="git diff --staged"
alias gs="git status"
alias gsl="git stash list"
alias gss="git add -A && git stash save"
gsa () {
    if (( $# == 0 )); then
        git stash apply
    else
        git stash apply stash@{$1}
    fi
}
unalias gsd
gsd () {
    if (( $# == 0 )); then
        git stash drop
    else
        git stash drop stash@{$1}
    fi
}
gsfirst(){
    git stash apply `gsl | head -n 1 | awk -F':' '{print $1}'`
}
gslast(){
    git stash apply `gsl | tail -n 1 | awk -F':' '{print $1}'`
}
alias gb="git branch"
alias gbl="git blame"
alias gblr="git blame --reverse"
fblame() {
    local dir=""
    local file=$1
    if (( $# > 1 )); then
        dir=$1
        file=$2
    elif [[ -e "src" ]]; then
        dir="src"
    fi
        
    git blame `ffind $dir $file | sed -n 1p`
}
alias gp="git push"
alias grh="git reset --hard"
alias gl="git lg"
#alias gpom="git push origin master"
alias gpo="git push origin"
function gitupstream() {
    git branch --set-upstream-to=origin/$(current_branch) $(current_branch)
}
alias battery="battery_pct_remaining"
alias facetime_kill="sudo killall VDCAssistant"
alias py=python
alias ipy=ipython
alias json="python -mjson.tool"
alias nocolor="sed \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g\""
alias optimizepngs="open -a ImageOptim *.png"
#convenient aliases for managing multiple jobs
for (( i=0; i < 10; i++ )); do
    alias $i="fg %$i"
done

export CLOJURE_JAR=`ffind /usr/local/Cellar/clojure/ clojure | grep .jar | tail -n 1`
alias clojure="java -cp $CLOJURE_JAR clojure.main"

export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA8_HOME=$JAVA_HOME
export JAVA6_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# virtualenv setup
# export WORKON_HOME=~/.venvs
# VIRTUALENV_HOME=/usr/local/bin/virtualenvwrapper.sh
# if [ ! -f  ]; then
#     source $VIRTUALENV_HOME
# fi
#export PROJECT_HOME=~/.Devel

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^W' kill-region

function longPrompt(){
    PROMPT_LENGTH="%~"
    precmd
}
function shortPrompt(){
    PROMPT_LENGTH="%1~"
    precmd
}
function mediumPrompt(){
    PROMPT_LENGTH="%2~"
    precmd
}

# until pull request is merged into oh-my-zsh, include the plugged_in function here
function plugged_in() {
    [ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ Yes') -eq 1 ]
}



BATTERY_BACK_TO_HEALTH="%U%{$fg[blue]%}%uBattery is back to health%{${reset_color}%}"
precmd () {
    #git_branch="$(__git_ps1 "%s")"
    branch="$(current_branch)" #branch will be changed but you want to save git_branch for later

    if [[ -z $branch ]]; then
        branch="" #do nothing
    else
        git_status="$(git status 2>/dev/null)"
        
        # to add a warning for a branch, do
        # `git config --local --add branch.BRANCHNAME.editwarning true` and
        # unset with `git config --local --unset branch.BRANCHNAME.editwarning
        branch_warning="branch.$(current_branch).editwarning=true"
        hide="$(git config -l)"

        if [[ $git_status =~ "All conflicts fixed but you are still merging." ]] || \
            [[ $git_status =~ "You have unmerged paths." ]]; then
            branch="[in merge] $branch"
        fi
        
        if [[ $hide =~ $branch_warning ]]; then
            branch="%{$bg[red]%} -- ${branch} -- %{$reset_color%}"
        else
            branch="(${branch})"
        fi
        
        if [[ $git_status =~ "Untracked files" ]]; then
            color="yellow"
        elif [[ $git_status =~ "You have unmerged paths." ]]; then
            color="yellow"
        elif [[ $git_status =~ "Changes not staged for commit" ]]; then
            color="yellow"
        elif [[ $git_status =~ "Changes to be committed" ]]; then
            color="magenta"
        elif [[ $git_status =~ "Your branch is ahead" ]]; then
            color="cyan"
        elif [[ $git_status =~ "nothing to commit" ]]; then
            color="blue"
        fi
        branch=" %{$fg_no_bold[$color]%}$branch%{$reset_color%}% "
    fi

    VENV=""
    if [[ $VIRTUAL_ENV != "" ]]; then
        VENV="%{$fg_no_bold[blue]%}(`basename $VIRTUAL_ENV`) "
    fi

    PROMPT="$VENV%U%{$fg_no_bold[green]%}$PROMPT_LENGTH%u %{$reset_color%}%$branch %{$fg_no_bold[cyan]%}$%{$reset_color%} "

    battery=`battery_pct`
    if [[ $battery == "no battery" ]]; then
        battery=""
    elif [[ $battery -le 20 ]]; then
        color="red"
        if plugged_in ; then
            color="green"
        fi
        if [[ $battery -le 10 ]]; then
            style="$bg[$color]$fg[black]"
        else
            style="$fg[$color]"
        fi
        battery="%U%{${style}%}%uBattery: $battery%%%{${reset_color}%}"
    else
        if [[ $RPROMPT != "" && $RPROMPT != $BATTERY_BACK_TO_HEALTH ]]; then
            battery=$BATTERY_BACK_TO_HEALTH
        else
            battery=""
        fi
    fi
    RPROMPT=$battery

    # TODO Display the time every 15/30 minutes in RPROMPT as Dark Blue
    # `date`
}


if [[ -z $PROMPT_LENGTH ]]; then
    mediumPrompt # don't reset to mediumPrompt after .zshrc is reloaded
fi

export PATH="/usr/local/bin:/usr/local/mybin:/usr/local/sbin"
PATH=$PATH":/usr/local/Cellar/go_google_appengine/"
PATH=$PATH":/usr/local/share/npm/bin/"
PATH=$PATH":usr/local/share/python"
PATH=$PATH":/usr/local/mongodb/bin:/usr/local/mysql/bin"
PATH=$PATH":/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
PATH=$PATH":$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools"
PATH=$PATH":$HOME/.rvm"

if [[ -e "$HOME/.rvm" ]]; then
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

function editMacKeyBindings() {
    dir=~/Library/KeyBindings
    if [ ! -d $dir ]; then
        mkdir $dir
    fi

    file=$dir/DefaultKeyBinding.dict
    if [ ! -f $file ]; then
        sudo touch $file
    fi
    sudo $EDITOR $file
    #sudo $EDITOR ~/.mac_keybindings
}


# No correct list
alias which="nocorrect which"
alias ffind="nocorrect ffind"

### ZSH Options ###
# `man zshoptions`
unsetopt AUTO_PUSHD
unsetopt AUTO_CD
setopt ALIASES
# setopt IGNORE_EOF
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f
#TRAPEXIT() {
    #echo $?
    #zsh
#}


### Notes
# `cd -` sends you back to the previous directory you were in
# trap finish EXIT # use at the end of a shell script, where finish() is a
  # self defined function to cleanup
# ab - Apache HTTP server benchmarking tool

source ~/.venmorc

killadobe() {
    # pkill -9 -f apache # kills processes named apache # http://www.quora.com/Linux/What-are-some-time-saving-tips-that-every-Linux-user-should-know/answer/Christian-Nygaard?__snids__=195709448&__nsrc__=2
    grepped=`ps ax | grep Adobe | awk '{print $1}'`
    processes=$(( `echo $grepped | wc -l` - 1 ))

    if (( $processes > 0 )); then
        kill `echo $grepped | head -n $processes`
    fi
}

# shortcut for copying files: cp foo{,.old} # cp foo{.old,} # http://www.pgrs.net/2007/9/6/useful-unix-tricks/
# Pressing alt+. will put in the previous command's last argument $ http://www.pgrs.net/2011/08/16/useful-unix-tricks-part-4/

# http://www.fizerkhan.com/blog/posts/What-I-learned-from-other-s-shell-scripts.html
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
GREEN_BOLD=$(tput setaf 2; tput bold)

function red() { echo -e "$RED$*$NORMAL" }
function green() { echo -e "$GREEN$*$NORMAL" }
function yellow() { echo -e "$YELLOW$*$NORMAL" }
function blue() { echo -e "$BLUE$*$NORMAL" }
function magenta() { echo -e "$MAGENTA$*$NORMAL" }
function cyan() { echo -e "$CYAN$*$NORMAL" }
function white() { echo -e "$WHITE$*$NORMAL" }

function require_curl() { which "curl" &>/dev/null; }
# SOMEVAR=${SOMEVAR:-http://localhost:8080} #Sometime, we want to use default value if user does not set the value.
# The ${#VARIABLE_NAME} gives the length of the value of the variable.
# To find base directory
# APP_ROOT=`dirname "$0"`
# To find the file name
# filename=`basename "$filepath"`
# To find the file name without extension
# filename=`basename "$filepath" .html`

export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'

export EC2_HOME="/usr/local/etc/ec2-api-tools-1.6.12.0"
export PATH=$PATH:$EC2_HOME/bin 
# source ~/.aws_profile

eval "$(direnv hook zsh)" # end with this
source ~/.dotfiles/z.sh
