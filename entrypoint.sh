#!/bin/sh -l

branches=`git branch -r --merged $GITHUB_ACTION_REF | grep -v "main$" | grep -v "master$" | grep -v "production$" | grep -v "staging$" | grep -v "$INPUT_PROTECTED_BRANCH$"`
for branch in $branches; do
    branch=`echo $branch | sed 's/remotes\/origin\///g'`
    if [[ $branch != $GITHUB_ACTION_REF && $branch != $INPUT_PROTECTED_BRANCH ]]; then
        git push origin --delete $branch
        echo "$branch removed."
    else
        echo "Cannot remove $branch."
    fi
done
