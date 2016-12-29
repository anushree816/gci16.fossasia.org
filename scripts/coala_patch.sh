#!/bin/bash
# Push Coala fixes back to the repo if on gh-pages branch
# only do this on gh-page branch
if [ "$TRAVIS_BRANCH" = "gh-pages" ]; then
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "coala-autofix-bot"
    git fetch --all
    git add .
    # check for staged changes
    git status --porcelain|grep "M"
    # if there are changes
    if [ "$?" = 0 ]; then
        git remote add origin-pages https://coala-autofix-bot:$COALA_FIXER@github.com/fossasia/gci16.fossasia.org.git
        git checkout -b gh-pages
        git pull --rebase origin gh-pages
        git commit --message "Coala auto-patch for Travis CI Build:$TRAVIS_BUILD_NUMBER | Generated by Travis CI"
        git push --quiet --set-upstream origin-pages gh-pages
    else
        echo "No changes detected. Not creating a patch."
    fi
else
    echo "Not creating a patch since not on gh-pages branch."
fi
