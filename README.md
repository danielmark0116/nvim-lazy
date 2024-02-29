# 💤 LazyVim

My config based on a starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Multiple configs for NVIM

1. Tweak your .zshrc with `nvms` alias
```bash
# NeoVIM config switch
alias lvim="NVIM_APPNAME=lazyvim nvim"

function nvims() {
  items=("default" "lazyvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Choose Neovim Config wariacie  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
```
2. Have, say, lazyvim config then at `.config/lazyvim` and `.config/lazyvim`
