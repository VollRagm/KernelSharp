@echo off

:: you have to set the path to whatever it is for you
@set ILCPATH = "E:\tools"

SETLOCAL ENABLEEXTENSIONS


@if not exist %ILCPATH%\ilc.exe (
  echo The DROPPATH environment variable not set.
  exit /B
)

@del Program.ilexe >nul 2>&1
@del Program.obj >nul 2>&1
@del Program.exe >nul 2>&1
@del Program.map >nul 2>&1
@del Program.pdb >nul 2>&1

@if "%1" == "clean" exit /B

csc.exe /nologo /debug:embedded /noconfig /nostdlib /runtimemetadataversion:v4.0.30319 Program.cs WDK.cs Runtime/CompilerHelpers.cs Runtime/CompilerServices.cs Runtime/System.cs Runtime/Runtime.cs /out:Program.ilexe /langversion:latest /unsafe || goto Error
%ILCPATH%\ilc Program.ilexe -o Program.obj --systemmodule Program --map Program.map -O || goto Error

:: Also set this path to your oath
link.exe "D:\Windows Kits\10\lib\10.0.19041.0\km\x64\ntoskrnl.lib" /nologo /subsystem:native /DRIVER:WDM Program.obj /entry:DriverEntry /incremental:no /out:Driver.sys || goto Error
@goto :EOF

:Error
@echo Tool failed.
exit /B 1