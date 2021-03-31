#!/bin/sh -l
HEAD_BRANCH=${INPUT_HEAD_BRANCH##*/}
branches=`git branch -r --merged $HEAD_BRANCH | grep -v "main$" | grep -v "master$" | grep -v "production$" | grep -v "staging$" | grep -v "$INPUT_PROTECTED_BRANCH$"`
for branch in $branches; do
    branch=`echo $branch | sed 's/origin\///g'`
    if [[ $branch != $HEAD_BRANCH && $branch != $INPUT_PROTECTED_BRANCH ]]; then
        git push origin --delete $branch
        echo "$branch removed."
    else
        echo "Cannot remove $branch."
    fi
done
