function _lime(){
    local line

    _arguments -C \
        "1: :(add remove start stop reset clear submit show)" \
        "*::arg:->args"

    case $line[1] in
        start|remove)
            _get_tasks_from_local
        ;;
        show)
            _get_objects
        ;;
    esac
}

function _get_tasks_from_local {
    function _format_issues(){
        cut -f 1,2 /home/valenca/Repos/bash_complete/task_list | \
            tr '\n' '\t' | \
            xargs -d $'\t' -n 2 printf "'%s:%s'\n" | \
            paste -sd ' '
    }
    _describe "local issues" "($(_format_issues))"
}

function _get_objects {
    _describe "objects" "(\
        'total_time:Total time logged since last clear' \
        'current_task:Issue currently being logged' \
        )"
}

compdef _lime lime