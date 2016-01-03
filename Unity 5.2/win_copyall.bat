@echo off
REM Copies all Unity XML Documentation files into the appropriate Unity application sub-folders for the default installation location


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


REM Copy to 5.X.X folders
echo %cd%
IF EXIST "C:\Program Files\Unity\Editor\Data\Managed" (
	echo Copying Engine and Editor files.
	COPY UnityEngine.xml "C:\Program Files\Unity\Editor\Data\Managed"
	COPY UnityEditor.xml "C:\Program Files\Unity\Editor\Data\Managed"
)

echo Copying UI files
COPY UnityEngine.UI.xml "C:\Program Files\Unity\Editor\Data\UnityExtensions\Unity\GUISystem"
COPY UnityEditor.UI.xml "C:\Program Files\Unity\Editor\Data\UnityExtensions\Unity\GUISystem\Editor"

echo Copying other extension files
COPY UnityEngine.Advertisements.xml "C:\Program Files\Unity\Editor\Data\UnityExtensions\Unity\Advertisements"
COPY UnityEngine.Networking.xml "C:\Program Files\Unity\Editor\Data\UnityExtensions\Unity\Networking"
COPY UnityEngine.Analytics.xml "C:\Program Files\Unity\Editor\Data\UnityExtensions\Unity\UnityAnalytics"

ECHO DONE!
pause


