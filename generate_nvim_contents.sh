#!/bin/bash

NVIM_DIR="$HOME/.config/nvim"

print_contents() {
  local dir="$1"
  local indent="$2"
  
  for entry in "$dir"/*; {
    if [ -d "$entry" ]; then
      echo "${indent}Directory: $(basename "$entry")"
      print_contents "$entry" "  $indent"
    elif [ -f "$entry" ]; then
      echo "${indent}File: $(basename "$entry")"
      echo "${indent}Contents:"
      sed "s/^/${indent}/" "$entry"
      echo ""
    fi
  }
}

print_contents "$NVIM_DIR" ""
