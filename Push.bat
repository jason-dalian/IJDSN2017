@echo off
@title windows git

set path=%path%;

echo\&echo

git add -v .
git commit -m '1'
git push origin master

echo\&echo done...
