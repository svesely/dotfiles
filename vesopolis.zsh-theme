PROMPT='\
%{$fg_no_bold[blue]%}[\
%{$fg_no_bold[red]%}\
%n@%m:\
%(!.%1~.%~)\
%{$fg_no_bold[green]%}$(git_prompt_info)\
%{$fg_no_bold[blue]%}]\
%{$reset_color%}$ '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
