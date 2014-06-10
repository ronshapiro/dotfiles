#!/bin/sh

# easily parse Logcat output
alog () {
    parser=ack
    if [[ -e `which ack` ]]; then
        parser=grep
    fi
    if (( $# == 0 )); then
        adb logcat -v time
    elif [[ $1 == "runtime" ]]; then
        pattern='E/AndroidRuntime'
        adb logcat -v time | $parser --ignore-case $pattern
    else
        adb logcat -v time | $parser --ignore-case $@
    fi
}

# take an android screenshot, adapted off alias from http://blog.shvetsov.com/2013/02/grab-android-screenshot-to-computer-via.html
ascreen(){
    _file="android_screenshot-`date +"%m_%d_%y-%H_%M_%S"`"
    _dir="$HOME/Desktop"
    target=$_dir/$_file.png
    adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > $target

    opened_already="no"
    uploaded_already="no"
    for arg in "$@"; do
        [[ $uploaded_already == "no" && ($arg == "upload" || $arg == "up") ]] && \
            uploaded_already="yes" && \
            cloudapp $target
        [[ $opened_already == "no" && $arg == "open" ]] && \
            opened_already="yes" && \
            open $target
    done
}

# alias to send broadcasted events to a device
alias broadcast="adb shell am broadcast"
alias genymotionshell="/Applications/Genymotion\ Shell.app/Contents/MacOS/genyshell ; exit;"
alias pidcat="~/code/open-source/pidcat/pidcat/pidcat.py --color-gc"
