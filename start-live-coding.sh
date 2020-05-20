#!/bin/sh

PROMPT_COMMAND=__prompt_command
export PROMPT_COMMAND
__prompt_command() {
    local EXIT="$?"

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local LightRed='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    PS1=""
    if [ $EXIT != 0 ]; then
        PS1+="${LightRed}"
    else
        PS1+="${Gre}"
    fi

    PS1+="██ ${EXIT}${RCol}\n"
    PS1+="\n"
    PS1+="────────────────────────────────────────────────────────────\n"
    PS1+="\n"
    PS1+="-> "
}
export -f __prompt_command

bash
