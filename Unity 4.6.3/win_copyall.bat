@echo off
REM Copies all Unity XML Documentation files into the appropriate Unity 4.6 application sub-folders for the default installation location


REM Copying to Program Files folder requires administrative privileges.
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------


REM Copy to 4.X.X folders
echo %cd%
IF EXIST "C:\Program Files (x86)\Unity\Editor\Data\Managed" (
	echo Copying Engine and Editor files.
	COPY UnityEngine.xml "C:\Program Files (x86)\Unity\Editor\Data\Managed"
	COPY UnityEditor.xml "C:\Program Files (x86)\Unity\Editor\Data\Managed"
)

FOR /f "tokens=*" %%G in ('dir /b /a:d "C:\Program Files (x86)\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\*"') do (
	echo Copying UI files to %%G
	COPY UnityEngine.UI.xml "C:\Program Files (x86)\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\%%G"
	COPY UnityEditor.UI.xml "C:\Program Files (x86)\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\%%G\Editor"
)

ECHO DONE!
pause


