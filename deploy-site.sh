#!/usr/bin/env bash -xe

# pass a commit message
message=$1

if [ "$message" == "" ]; then
	#use last git commit message for deploying into github pages
	message=`git log -1 --pretty=%B`
fi

# generate static site into public folder
hugo

# push changes to hugo repo
git add .
git commit -m "$message"
git push

# push files into github pages
cd public
git add .
git commit -m "$message"
git push origin master

# go back to source directory
cd ..

