#!/bin/bash
# File to store blocked domains
BLOCKED_FILE="online-games.txt"
while :; do
    # Prompt user for URL or domain input
    read -p "Enter URL or domain: " input

    # Remove http:// or https://, trailing slash, and everything after the first slash
    domain=$(echo "$input" | sed -E 's~^https?://~~' | sed -E 's~/.*$~~')

    # Check if the file exists, create it if it doesn't
    [ ! -f "$BLOCKED_FILE" ] && touch "$BLOCKED_FILE"

    # Check if the domain (with 0.0.0.0 prefix) already exists in the file
    if grep -q "0.0.0.0 $domain" "$BLOCKED_FILE"; then
        echo "[err] $domain is already on the list."
    else
        # Append to online-games.txt with 0.0.0.0 prefix
        echo "0.0.0.0 $domain" >> online-games.txt
        echo "[ok] $domain"
    fi
done
