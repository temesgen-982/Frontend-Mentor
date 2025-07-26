#!/bin/bash

while read -r url path; do
  # Skip empty lines
  [ -z "$url" ] && continue

  # If no path is specified, derive it from the repo name
  if [ -z "$path" ]; then
    path=$(basename "$url" .git)
  fi

  if [ -d "$path" ]; then
    echo "⚠️  Skipping $path — already exists."
    continue
  fi

  echo "➕ Adding submodule: $url → $path"
  git submodule add "$url" "$path"
done < submodules.txt

echo "✅ Done adding submodules."
