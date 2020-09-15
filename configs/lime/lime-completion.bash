function _lime() {    
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    case $COMP_CWORD in
        1)
            COMPREPLY=( $(compgen -W "add remove start stop reset sprint clear submit show status" -- "${cur}") )
            ;;
        2)
            case $prev in
                start|remove)
                    cur=$(_get_cword)
                    local completions=$(cat ~/.lime/task_list.txt | tr '\t' " " ) 

                    local OLDIFS="$IFS"
                    local IFS=$'\n'
                    COMPREPLY=( $(compgen -W "$completions" -- "$cur") )
                    IFS="$OLDIFS"
                    if [[ ${#COMPREPLY[*]} -eq 1 ]]; then #Only one completion
                        COMPREPLY=( "" ) #Remove ' - ' and everything after
                    fi
                    return 0
                    ;;
                show)
                    COMPREPLY=( $(compgen -W "total_time current_task" -- ${cur}) )
           esac
           ;;
    esac
} && complete -F _lime lime
