if [[ -z $TMUX ]]; then
    TMUX_SESSIONS=`tmux list-sessions -F "#{session_name}ABC#{?session_attached,attached,not_attached}" 2>&1`
    TMUX_FOUND=0
    for i in $TMUX_SESSIONS
    do
        IS_ATTACHED=`echo $i | awk '{split($0,array,"ABC"); print array[2]}'`
        if [[ $IS_ATTACHED == "not_attached" ]]; then
            TMUX_FOUND=1
            tmux attach -t `echo $i | awk '{split($0,array,"ABC"); print array[1]}'`
            break
        fi
    done

    if [[ $TMUX_FOUND -eq 0 ]];then
        tmux new-session
    fi
fi
