@echo off
if x%1 == x goto default
if %1 == --pack goto pack
if %1 == --clean goto clean
if %1 == --clean-all goto cleanall
if %1==--help goto help
if %1==-h goto help
if %1==-? goto help
goto run

:default
emacs-build.cmd --nativecomp --clone --branch emacs-29 --slim --without-lcms2 --without-xpm --with-rsvg --build
goto:eof

:pack 
emacs-build.cmd --nativecomp --clone --branch emacs-29 --slim --without-lcms2 --without-xpm --with-rsvg --pack-all
goto:eof

:cleanall
cd %~dp0 && for %%i in (git build zips pkg) do if exist %%i rmdir /S /Q %%i
goto:eof

:clean
cd %~dp0 && for %%i in (build pkg) do if exist %%i rmdir /S /Q %%i
goto:eof

:help
powershell -noprofile -c scripts\setup-msys2.ps1
.\scripts\msys2.cmd -c "./emacs-build.sh --help"
goto:eof

:run
powershell -noprofile -c scripts\setup-msys2.ps1
.\scripts\msys2.cmd -c "./emacs-build.sh %*"
