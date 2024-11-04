

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/x011bx2xa0xw2qwlk7vzkgpf7l005qxb-zsh-5.9/share/zsh/$ZSH_VERSION/help"





# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit
source /nix/store/vv28ikvsqidxmkgk17pjrs9ds542c1yi-zsh-autosuggestions-0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh







# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="/home/adibf/.local/share/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


cdf() {
  cd "/home/adibf/projects/flik-backend/$1"
}
cdc() {
  cd "/home/adibf/.config/$1"
}
gdb() {
  git branch | grep "$1" | xargs git branch -D
}
gl() {
  local line_count="${1:-5}"  # Default to 5 if no argument is provided
  git log --pretty=format:"%h | %s | %aN | %aE | %aD" -n "$line_count"
}
cleangen() {
  sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
  sudo nix-store --gc
  sudo nixos-rebuild boot
}
dcu() {
  docker compose -f $1 up
}
ovpn() {
  openvpn3 session-start --config /home/adibf/projects/adib.ovpn
  openvpn3 log --config /home/adibf/projects/adib.ovpn
}


# Aliases
alias -- 'gcloud'='$HOME/google-cloud-sdk/bin/gcloud'
alias -- 'kys'='pgrep openvpn3 && sudo pkill -9 openvpn3; sudo poweroff'
alias -- 'nixhup'='home-manager switch'
alias -- 'nixls'='sudo nix-env --list-generations 
        --profile /nix/var/nix/profiles/system'
alias -- 'nixup'='sudo nixos-rebuild switch'

# Named Directory Hashes


source /nix/store/dk9jcdv1g4rh6fxsi28vlnx6k0b5ri6n-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()




