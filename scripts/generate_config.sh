#!/bin/bash

function promt_for_confirmation {
    while true; do
        read -p "$1" choice
        choice=${choice:-"$2"}
        case "$choice" in 
            n|N)
                echo 0
                break ;;
            y|Y)
                echo 1
                break ;;
            * ) echo "invalid choice $choice" ;;
        esac
    done
}

function prompt_for_input {
    local input_value=""
    while [[ -z "$input_value" ]]; do
        read -p "$1" input_value
    done
    echo $input_value
}

lighthouse=
host=
lighthouse_ip=

# parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --lighthouse) lighthouse="$2"; shift ;;
        --host) host="$2"; shift ;;
        --lighthouse-ip) lighthouse_ip="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$lighthouse" ]]; then
    lighthouse=$(promt_for_confirmation "Is node a lighthouse? (y/N) " "y")
fi
if [[ "$lighthouse" -eq 0 ]]; then
    lighthouse=false
else
    lighthouse=true
fi

if [[ -z "$host" ]]; then
    host=$(prompt_for_input "Enter node name: ")
fi

if [[ -z "$lighthouse_ip" ]]; then
    lighthouse_ip=$(prompt_for_input "Enter lighthouse nebula ip: ")
fi

lighthouse_real_ip=$(prompt_for_input "Enter lighthouse real ip: ")
port=$(prompt_for_input "Enter port which should be used by nebula: ")

config=`cat templates/config_template.yml`

config=${config//\{host\}/$host}
config=${config//\{lighthouse_ip\}/$lighthouse_ip}
config=${config//\{lighthouse_real_ip\}/$lighthouse_real_ip}
config=${config//\{port\}/$port}
config=${config//\{lighthouse\}/$lighthouse}

echo "$config" > config_"$host".yml
