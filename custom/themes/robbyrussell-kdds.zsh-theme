bindkey -v

function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    PROMPT_SYMBOL="🦂 "
  else
    PROMPT_SYMBOL=""
  fi
  zle reset-prompt
}

zle -N zle-keymap-select

local userhost="%{$fg_bold[blue]%n@%m%f%{$reset_color%}"
PROMPT="
[$userhost] %B%{$FG[214]%}%~%f%{$reset_color%}"
PROMPT+=' $(git_prompt_info)
${PROMPT_SYMBOL}%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
