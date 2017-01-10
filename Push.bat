@echo off
@title windows git

set path= %path%;C:\Users\Administrator\AppData\Local\GitHub\PortableGit_d7effa1a4a322478cd29c826b52a0c118ad3db11\cmd

echo\&echo

git add -v .
git commit -m '1'


git remote rm origin 

git remote add origin https://naigao.jin@gmail.com:Jinnaigao1977614@github.com/username/test.git

git push origin master

echo\&echo done...
