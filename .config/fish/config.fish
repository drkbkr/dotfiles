clear

alias ts='sudo tailscaled'
alias tsu='tailscale up --accept-routes'
alias tsd='tailscale down'
alias tss='tailscale status'

if status --is-interactive 
and test -e /usr/bin/starship
  source ("/usr/bin/starship" init fish --print-full-init | psub)
end
