alias ..="cd .."
alias ...="cd ../.."

alias h='cd ~'
alias c='clear'
alias art=artisan

function artisan() {
    php artisan "$@"
}

function nginx-test() {
    nginx -t
}

function nginx-reload() {
    nginx -s reload
}