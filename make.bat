set path= %path%;C:\Users\Administrator\AppData\Local\GitHub\PortableGit_d7effa1a4a322478cd29c826b52a0c118ad3db11\cmd;C:\Program Files (x86)\Adobe\Acrobat 11.0\Acrobat


@taskkill /f /IM Acrobat.exe
del *.bak
del *.sav
del *.aux

latex Main.tex     
bibtex Main    
latex Main.tex
latex Main.tex
dvipdfm Main.dvi


del *.bak
del *.sav
del *.log
del *.dvi
del *.asv
del *.aux
del *.blg

@echo off
@title windows git
echo\&echo
git add -v .
git commit -m '2'
git push origin master
echo\&echo done...

Acrobat.exe   main.pdf