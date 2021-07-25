

@ECHO OFF
rem setlocal enabledelayedexpansion

set LILYPOND="C:\Program Files (x86)\LilyPond-2.22.1\usr\bin\lilypond.exe"

set GEN=".\pdf-generated"
mkdir %GEN%

for %%f in (D:\01.lilypond\01.github\cadoanhienlinh-phucsinh\nhac\*.ly) do (
  set /p val=<%%f
  echo "fullname: %%f"
  echo "name: %%~nf"
  
  %LILYPOND% --output="%GEN%\%%~nf" -dno-point-and-click --pdf "%%f"
)

pdftk %GEN%\*.pdf cat output nhac.pdf

pdflatex so-trang-chan-le.tex

del /s /f /q %GEN% nhac.pdf *.aux *.log
