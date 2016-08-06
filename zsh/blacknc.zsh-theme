local ret_status="%(?:%{$fg[yellow]%}➜ :%{$fg[red]%}➜ )"
PROMPT='%{$fg[red]%}%n ${ret_status} %{$fg[green]%}%c $(git_prompt_info)✗ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}) %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%})"
