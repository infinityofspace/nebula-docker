#!/bin/bash

read -p "Enter certificate authority name: " ca_name

echo "Generating self signed certificate authority..."
docker run \
    --rm \
    -v $(pwd)/certs:/etc/nebula/certs \
    ghcr.io/infinityofspace/nebula-docker:latest \
    nebula-cert ca \
        -name "$ca_name" \
        -out-crt /etc/nebula/certs/ca.crt \
        -out-key /etc/nebula/certs/ca.key

while true; do
    read -p "Setup lighthouse? (Y/n) " choice
    choice=${choice:-y}
    case "$choice" in 
        n|N) break ;;
        y|Y)
            . setup_node.sh --lighthouse
            break;;
        * ) echo "invalid choice $choice" ;;
    esac
done

while true; do
    read -p "Setup aditional node? (Y/n) " choice
        choice=${choice:-y}
        case "$choice" in 
            n|N) break ;;
            y|Y)
                . setup_node.sh
                break;;
            * ) echo "invalid choice $choice" ;;
        esac
    done