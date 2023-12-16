#!/bin/bash

while IFS= read -r line; do
    brew install "$line"
done < brew_list.txt
