#!/bin/sh

# Enumerate dir
for current_dir in $(find ./ -maxdepth 1 -type d); do
    echo "Enumerating child directory size of $current_dir"

    du -h --max-depth=1 $current_dir

    echo ""
done

