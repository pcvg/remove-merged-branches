#!/bin/sh -l
GITHUB_BRANCH_ACTION=${INPUT_GITHUB_BRANCH_ACTION##*/}
branches=`git branch -r --merged $GITHUB_BRANCH_ACTION | grep -v "main$" | grep -v "master$" | grep -v "production$" | grep -v "staging$" | grep -v "$INPUT_PROTECTED_BRANCH$"`
for branch in $branches; do
    branch=`echo $branch | sed 's/origin\///g'`
    if [[ $branch != $GITHUB_BRANCH_ACTION && $branch != $INPUT_PROTECTED_BRANCH ]]; then
        git push origin --delete $branch
        echo "$branch removed."
    else
        echo "Cannot remove $branch."
    fi
done
