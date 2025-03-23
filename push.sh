#!/usr/bin/env bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

print_centered_message() {
    local message="$1"
    local color="${2:-$BLUE}"
    local width=$(tput cols)
    local message_length=${#message}
    local padding=$(((width - message_length - 2) / 2))

    printf "${color}%*s${RESET}" $padding | tr ' ' '='
    printf " ${color}%s${RESET} " "$message"
    printf "${color}%*s${RESET}\n" $padding | tr ' ' '='
}

current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "dev" ]; then
    printf "${RED}Error: You are not on the correct branch. Aborting.${RESET}\n"
    exit 1
fi

print_centered_message "Updating dev branch..." "${BLUE}"

git add -A

if [[ -z $1 ]]; then
    git commit -m Update
else
    git commit -m "$1"
fi

git push origin dev

print_centered_message "Remote branch 'dev' updated. Recreating master branch..." "${BLUE}"

git branch -D master || true
git push origin --delete master || true
git switch -c master

print_centered_message "Local branch 'dev' copied to 'master'. Normalizing files..." "${BLUE}"

python -B summary.py
python -B normalize_img_links.py
python -B normalize_internal_links.py

print_centered_message "Files normalized. Updating master branch..." "${BLUE}"

git add -A
git commit -m Update
git push origin master

print_centered_message "Remote branch 'master' updated. Switching back to dev..." "${BLUE}"

git switch dev

print_centered_message "Done!" "${GREEN}"
