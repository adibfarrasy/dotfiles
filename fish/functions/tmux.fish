function tmx
    tmux new-session -d -s adibf
    tmux new-window -n file
    tmux new-window -d -n work
    tmux new-window -d -n dojo
    tmux attach-session -d -t adibf
end
