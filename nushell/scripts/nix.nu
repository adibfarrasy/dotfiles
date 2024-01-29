def cleangen [] {
    sudo nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system
    sudo nix-store --gc
}
alias nixls = sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
