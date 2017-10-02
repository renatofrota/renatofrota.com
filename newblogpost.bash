#!/bin/bash
date=$(date +%Y-%m-%d)
time=$(date +%H:%M:%S)
read -erp "Nome da nova publicação: " postname
slug="$(echo $postname | iconv -f utf-8 -t ascii//translit | sed 's, ,-,g' | tr '[:upper:]' '[:lower:]' | sed -e 's,[^a-z0-9\._-],,g')"
file="content/blog/${date}-$slug.md"
[[ -d "$file" ]] && echo "File exists: $file" && exit 1
echo "---
date: \"$date $time\"
title: \"$postname\"
slug: \"$slug\"
description: \"\"
---
" > $file
echo "Arquivo criado:"
echo "$file"
vim $file
exit 0
