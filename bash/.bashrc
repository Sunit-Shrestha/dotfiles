#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. /usr/share/nvm/init-nvm.sh
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# if [[ -r /usr/share/bash-completion/bash_completion ]]; then
#   . /usr/share/bash-completion/bash_completion
# fi

alias vi=nvim
alias vim=nvim
alias yay='yay --sudoloop --noconfirm'
alias spotifydl='spotdl --id3-separator ", " --bitrate 320k'
alias spotify-dlp='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k --embed-metadata --embed-thumbnail --add-metadata -o "%(artist,uploader)s - %(title)s.%(ext)s" --cookies-from-browser brave'

function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Created by `pipx` on 2025-08-09 10:58:08
export PATH="$PATH:/home/sunit/.local/bin"
