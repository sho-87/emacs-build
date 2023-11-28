@echo off
if x%1 == x goto default
if %1 == --clean goto clean
if %1 == --clean-all goto cleanall
if %1==--help goto help
if %1==-h goto help
if %1==-? goto help
goto run

:cleanall
cd %~dp0 && for %%i in (git build zips pkg) do if exist %%i rmdir /S /Q %%i
goto:eof

:clean
cd %~dp0 && for %%i in (build pkg) do if exist %%i rmdir /S /Q %%i
goto:eof

:default
emacs-build.cmd --nativecomp --clone --branch emacs-29 --deps --build --strip --no-compress --with-gnutls --with-modules --with-json --with-tree-sitter --with-sqlite3 --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-xpm --without-dbus --without-gconf --without-gsettings --without-imagemagick --without-pop --without-mailutils --without-sound --pack-emacs
goto:eof

:help
powershell -noprofile -c scripts\setup-msys2.ps1
.\scripts\msys2.cmd -c "./emacs-build.sh --help"
goto:eof

:run
powershell -noprofile -c scripts\setup-msys2.ps1
.\scripts\msys2.cmd -c "./emacs-build.sh %*"
