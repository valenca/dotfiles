_telnet() {
  COMPREPLY=()
  local cur
  cur=$(_get_cword)
  local completions="10.10.10.10 - routerA
10.10.10.11 - routerB
10.20.1.3 - routerC"

  local OLDIFS="$IFS"
  local IFS=$'\n'
  COMPREPLY=( $( compgen -W "$completions" -- "$cur" ) )
  IFS="$OLDIFS"
  if [[ ${#COMPREPLY[*]} -eq 1 ]]; then #Only one completion
    COMPREPLY=( ${COMPREPLY[0]%% - *} ) #Remove ' - ' and everything after
  fi
  return 0
}
complete -F _telnet -A hostnames telnet