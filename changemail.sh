#!/bin/sh

if [ -z "$1" ]
then
        echo "missing remote repository name"
        echo "usage: $0 <repo-name> <user-name> <user-mail>"
        echo "ex: $0 origin bob bob@leponge.fr"
        exit 1
fi

origin=mailmap
remote=$(git remote get-url $1)
echo "Using alias <$origin> for repository <$remote>"

if [ -z "$2" ]
then
        echo "missing new name"
        echo "usage: $0 <repo-name> <user-name> <user-mail>"
        echo "ex: $0 origin bob bob@leponge.fr"
        exit 1
fi

if [ -z "$3" ]
then
        echo "missing new email"
        echo "usage: $0 <repo-name> <user-name> <user-mail>"
        echo "ex: $0 origin bob bob@leponge.fr"
        exit 1
fi

name=$2
email=$3

echo "Will change all emails to: $name <$email>"

filter="s/^[^a-zA-Z]*/$name <$email> /"
git shortlog --summary --numbered --email | sed -e "$filter" > /tmp/mailmap

git filter-repo --mailmap /tmp/mailmap --force
git remote add $origin $remote
git push --set-upstream $origin main --force
git push --set-upstream $origin develop --force
git reset --hard $origin/main
git reset --hard $origin/develop

rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now

grep -v 'refs/replace' .git/packed-refs > /tmp/packref
mv /tmp/packref .git/packed-refs

git gc --prune=now
git gc --aggressive --prune=now

git push origin --all

git config --global --unset-all user.email
git config --global --unset-all user.name

git config --unset-all user.email
git config --unset-all user.name

git config user.name $name
git config user.email $email
