#! /usr/bin/env sh

sudo apt install git silversearcher-ag curl

path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

emacs_dir="${HOME}/.emacs"
local_dir="${emacs_dir}/private/local"
user_file="${local_dir}/user.el"
# spacemacs="${HOME}/.spacemacs"

git clone https://github.com/syl20bnr/spacemacs "$emacs_dir"
mkdir -p "$local_dir"
ln -s "${path}/user.el" "$user_file"
