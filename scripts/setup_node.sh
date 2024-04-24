#!/bin/bash

if [[ "$@" =~ "--lighthouse" ]] ; then
    lighthouse=1
else
    while true; do
        read -p "Is the node a lighthouse? (y/N) " choice
        choice=${choice:-y}
        case "$choice" in 
            n|N)
                lighthouse=0
                break ;;
            y|Y)
                lighthouse=1
                break ;;
            * ) echo "invalid choice $choice" ;;
        esac
    done
fi

read -p "Enter node name: " node_name
read -p "Enter nebula ipv4 address and network in CIDR notation (like 10.0.0.1/8): " cidr_ip
read -p "(optional) Enter groups (multiple groups seperated by comma): " groups
docker run \
    --rm \
    -v $(pwd)/certs:/etc/nebula/certs \
    ghcr.io/infinityofspace/nebula-docker:latest \
    nebula-cert sign \
        -name "$node_name" \
        -ip "$cidr_ip" \
        -groups "$groups" \
        -ca-crt /etc/nebula/certs/ca.crt \
        -ca-key /etc/nebula/certs/ca.key \
        -out-crt /etc/nebula/certs/"$node_name".crt \
        -out-key /etc/nebula/certs/"$node_name".key

while true; do
    read -p "Generate basic config? (Y/n) " choice
    choice=${choice:-y}
    case "$choice" in 
        n|N) break ;;
        y|Y)
            if [[ $lighthouse -eq 0 ]]; then
                . generate_config.sh --lighthouse 0 --host "$node_name"
            else
                . generate_config.sh --lighthouse 1 --host "$node_name" --lighthouse-ip "$cidr_ip"
            fi
            break ;;
        * ) echo "invalid choice $choice" ;;
    esac
done
