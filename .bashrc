# TMUX
#if which tmux 2>&1 >/dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#fi

#############################################
# Attach tmux to the first detached session 
#############################################




# Thanks from https://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtplain='\033[2m'
txtend='\033[0m'
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
bakgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White

function shortPrompt(){
    PROMPT_LENGTH="\W"
}
function longPrompt(){
    PROMPT_LENGTH="\w"
}
shortPrompt

#PROMPT_COMMAND tells bash to call format_PS1 every time prompt is requested,
#which will set PS1
PROMPT_COMMAND=format_PS1 

export EDITOR=emacs
export RUBYOPT="w"

ANDROID_HOME=~/coding/android-sdks
alias aliases="alias -p" #print all aliases
alias .bashrc="$EDITOR ~/.bashrc"
alias .tmux="$EDITOR ~/.tmux.conf"
alias reload_bash="source ~/.bash_profile"
alias .reload_bash=reload_bash
alias e=emacs
alias ackl="ack -i --literal"
alias .emacs="$EDITOR ~/.emacs"
alias ls="ls -G"
alias mkdir="mkdir -p" #create intermediate path for directory
alias untar="tar -zxvf"
alias pt="ps -e -o pid,command | grep"
alias start_apache="sudo apachectl restart"
export LSCOLORS="bx"

function xkcdnode(){
    cd ~/coding/xkcd-node
    alias server="supervisor -w .,db,util,email app.js"
    alias scrape="curl localhost:5000/scrape"
    alias comics_drop="curl localhost:5000/comics_drop"
    alias whatifs_drop="curl localhost:5000/whatifs_drop"
    alias users_drop="curl localhost:5000/users_drop"
}

## Notes Section
## convert -> convert between image types
## rsync and rcp -> remote file copy
## git config --system --add color.ui always

# thank you @shreyansb (https://github.com/shreyansb/dotfiles/blob/master/bash/bash_profile)
# and https://gist.github.com/31967 for PROMPT_COMMAND
function format_PS1() {
    git_branch="$(__git_ps1 "%s")" 
    output="${git_branch}" #output will be changed but you want to save git_branch for later

    if [[ -z $git_branch ]]; then
        output=""
    #bplock the dotfiles repo from showing the branch
    elif [[ $git_branch == "master-dotfiles" ]]; then
        output=""
    else
        status="$(git status 2>/dev/null)"
        
        # to add a warning for a branch, do `git config --local --add branch.BRANCHNAME.editwarning true` and unset with `git config --local --unset branch.BRANCHNAME.editwarning
        branch_warning="branch.${git_branch}.editwarning=true"
        hide="$(git config -l)"
        
        if [[ $hide =~ $branch_warning ]]; then
            output="\[${bakred}\] -- ${output} -- \[${txtend}\]"
        else
            output="(${output})"
        fi
        
        if [[ $status =~ "Untracked files" ]]; then
            output="\[${txtylw}\]${output}\[${txtend}\]"
        elif [[ $status =~ "Changes not staged for commit" ]]; then
            output="\[${txtylw}\]${output}\[${txtend}\]"
        elif [[ $status =~ "Changes to be committed" ]]; then
            output="\[${txtpur}\]${output}\[${txtend}\]"
        elif [[ $status =~ "Your branch is ahead" ]]; then
            output="\[${txtcyn}\]${output}\[${txtend}\]"
        elif [[ $status =~ "nothing to commit" ]]; then
            output="\[${txtblu}\]${output}\[${txtend}\]"
        fi
        output=" $output"
    fi
    
    export PS1="\[${undgrn}\]$PROMPT_LENGTH\[\e[m\]$output \$ "
}

alias cdv="cd ~/coding/venmo-android/"
alias crash="cd ~/Documents/Code/Venmo/crash-reporter"
alias cdscripts="cd /usr/local/mybin/"

#venmo
export VGIT_USERNAME=ronshapiro # use your github username
if [ -f ~/venmo-devops/venmo_host_aliases ]; then
   source ~/venmo-devops/venmo_host_aliases
fi


[[ -s "/Users/ronshapiro/.rvm/scripts/rvm" ]] && source "/Users/ronshapiro/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#running `brew --prefix` takes ~.7 seconds - running it twice took 
#quite a while. I put replaced it with "/usr/local", which is what
#the default is.
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

bind '"\e[A": history-search-backward' # bind up arrow
bind '"\e[B": history-search-forward'  # bind down arrow
bind '"\C-n": history-search-forward'  
bind '"\C-p": history-search-backward'

PATH="/usr/local/bin:/usr/local/mybin:$PATH"
PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
PATH="$PATH:/usr/local/sbin:/usr/local/mongodb/bin" # if not already present
PATH="$PATH:/usr/local/mysql/bin"

export LESS=-RFX
export ACKRC=".ackrc" #allow directory specific .ackrc files
export GREP_OPTIONS='-n --color=always --line-number -H -I -C 1 --exclude=*.pyc -R --exclude-dir=.git'

alias chrome-no-security="open -a /Applications/Google\ Chrome.app --args --disable-web-security"

###How to add ssh without a password:
#`scp ~/.ssh/id_rsa.pub USER@HOST:~/.ssh/authorized_keys2`
#you might need to do `chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys2` too
alias clic="ssh -X rds2149@clic.cs.columbia.edu"
alias cunix="ssh rds2149@cunix.cc.columbia.edu"
alias mcoder="mencoder mf://pngs/*.png -mf fps=50 -ovc lavc -lavcopts vcodec=msmpeg4v2 -oac copy -o recording.avi"

alias saveToICloud="defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool" # use this alias followed by true/false
