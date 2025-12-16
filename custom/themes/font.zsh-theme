# Git prompt symbols
SCM_NONE_CHAR=''
SCM_THEME_PROMPT_DIRTY=" %F{red}✗%f"
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX="%F{green}|"
SCM_THEME_PROMPT_SUFFIX="|%f"
ZSH_THEME_GIT_PROMPT_DIRTY=$SCM_THEME_PROMPT_DIRTY
ZSH_THEME_GIT_PROMPT_CLEAN=$SCM_THEME_PROMPT_CLEAN
ZSH_THEME_GIT_PROMPT_PREFIX=$SCM_THEME_PROMPT_PREFIX
ZSH_THEME_GIT_PROMPT_SUFFIX=$SCM_THEME_PROMPT_SUFFIX

# Clock settings
THEME_SHOW_CLOCK=true
THEME_CLOCK_COLOR="%F{blue}"
THEME_CLOCK_FORMAT="%I:%M:%S"

# Python virtualenv
ZSH_THEME_VIRTUAL_ENV_PROMPT='(%s) '

# Prompt function
function build_prompt() {
  local exit_code=$?
  local ret_color=""
  [[ $exit_code -eq 0 ]] && ret_color="%F{green}" || ret_color="%F{yellow}"

  local clock=""
  if [[ "$THEME_SHOW_CLOCK" == "true" ]]; then
    clock="${THEME_CLOCK_COLOR}$(date +$THEME_CLOCK_FORMAT)%f "
  fi

  local python_env=""
  [[ -n "$VIRTUAL_ENV" ]] && python_env="%F{white}($(basename $VIRTUAL_ENV))%f "

  local userhost="%F{gray}%n@%m%f"
  local cwd="%F{cyan}%~%f"

  PROMPT="${clock}${python_env}${userhost} ${cwd} \$(git_prompt_info)${ret_color}→ %f"
}

# Git status function
function git_prompt_info() {
  local git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [[ -n "$git_dir" ]]; then
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_DIRTY$ZSH_THEME_GIT_PROMPT_SUFFIX"
    else
      echo "$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_CLEAN$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
  fi
}

precmd_functions+=(build_prompt)
