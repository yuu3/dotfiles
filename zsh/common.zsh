# valgrind
alias dvalgrind="valgrind -v --error-limit=no --leak-check=full --leak-resolution=high --show-reachable=yes 2>&1"
alias dcvalgrind="valgrind -v --error-limit=no --leak-check=full --leak-resolution=high --show-reachable=yes --trace-children=yes 2>&1"

# vim
alias vin="vim -u NONE --noplugin"
alias agit="vi -c Agit"

alias emacs='emacs -nw'
#alias ekill='emacsclient -e "(kill-emacs)"'

# git
alias g="git"
alias gitlog="git log --oneline --graph --decorate"
alias gitco="git checkout"
alias gita="git add"
alias gitc="git commit"
alias gits="git status"
alias gitl='git log'
alias gitd="git diff"
alias gitdc="git diff --cached"
alias gitru="git remote update"
alias lg="git lg"
alias lga="git lga"

# エイリアスいろいろ
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias lv="lv -c"
alias grep="grep --color=auto"
alias rsync="rsync --progress"
alias pc="peco"
