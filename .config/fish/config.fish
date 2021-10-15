clear

alias ts='tailscaled'
alias tsu='tailscale up --accept-routes'
alias tsd='tailscale down'
alias tss='tailscale status'

if status --is-interactive
  source ("/usr/bin/starship" init fish --print-full-init | psub)
end
