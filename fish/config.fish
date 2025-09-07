if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -U fish_greeting
fish_config prompt choose arrow
zoxide init fish | source
alias cd="z"
# Node.js global packages
if test -d ~/.npm-global/bin
    set -gx PATH ~/.npm-global/bin $PATH
end

# NPM global packages (alternative location)
if test -d ~/.local/share/npm/bin
    set -gx PATH ~/.local/share/npm/bin $PATH
end

# System npm global packages
if test -d /usr/local/bin
    set -gx PATH /usr/local/bin $PATH
end

# Python user packages
if test -d ~/.local/bin
    set -gx PATH ~/.local/bin $PATH
end

# Cargo (Rust) packages
if test -d ~/.cargo/bin
    set -gx PATH ~/.cargo/bin $PATH
end

# Go packages (if you use Go)
if test -d ~/go/bin
    set -gx PATH ~/go/bin $PATH
end

# Check if npm is installed and add its global bin path
if command -v npm >/dev/null
    set -gx PATH (npm config get prefix)/bin $PATH
end
