#!/bin/bash
hugo
git add .
git commit -m 'site update'
git push origin master
cd public
git add .
git commit -m 'site update'
git push origin master