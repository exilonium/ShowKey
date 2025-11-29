#!/usr/bin/env bash
# Key visualizer showing last few keypresses
# Usage: ./script.sh [--ignore key1,key2,...] [--layout colemak_dh]

tput civis
trap "tput cnorm; exit" INT

keys=()
ignore_keys=()
layout="qwerty"

# Colemak-DH mapping (QWERTY -> Colemak-DH)
declare -A colemak_map=(
    [q]=q [w]=w [e]=f [r]=p [t]=b [y]=j [u]=l [i]=u [o]=y [p]=\;
    [a]=a [s]=r [d]=s [f]=t [g]=g [h]=m [j]=n [k]=e [l]=i [;]=o
    [z]=x [x]=c [c]=d [v]=v [b]=z [n]=k [m]=h [,]=, [.]=. [/]=/
)

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --ignore)
            IFS=',' read -ra ignore_keys <<< "$2"
            shift 2
            ;;
        --layout)
            layout="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

keyd monitor | while read -r line; do
    if [[ $line == *" down" ]]; then
        key=$(echo "$line" | awk '{print $(NF-1)}')
        
        # Apply layout mapping
        if [[ "$layout" == "colemak_dh" ]] && [[ -n "${colemak_map[$key]}" ]]; then
            key="${colemak_map[$key]}"
        fi
        
        # Check if key should be ignored
        skip=false
        for ignore in "${ignore_keys[@]}"; do
            if [[ "$key" == "$ignore" ]]; then
                skip=true
                break
            fi
        done
        
        if [[ "$skip" == false ]]; then
            keys+=("$key")
            if [ ${#keys[@]} -gt 4 ]; then
                keys=("${keys[@]:1}")
            fi
        fi
        
        clear
        echo -e "\n   Recent keys:\n"
        for k in "${keys[@]}"; do
            echo "   $k"
        done
        echo -e "\n   Press any key... (Ctrl+C to exit)"
    fi
done
