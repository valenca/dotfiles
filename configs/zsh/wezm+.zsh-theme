PROMPT='%{${fg_bold[white]}%}%n%{$reset_color%}%{${fg_bold[blue]}%}:%{$reset_color%}%1/%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg_bold[blue]%}>>%{$reset_color%} '
RPROMPT='%{$fg[white]%}$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}: %{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"
