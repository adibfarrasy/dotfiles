if status is-interactive
    # Commands to run in interactive sessions can go here
    if test "$(tty)" = "/dev/tty1"
        exec sway
    end
end
 
set fish_greeting

theme_gruvbox dark medium
