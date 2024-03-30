@echo off
SetLocal EnableExtensions DisableDelayedExpansion


:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo Administrator rights are required to run this script properly.
    echo.
    pause
    color 7
    exit
)


:main
cls
title Interactive Batch Script Template
color 0a
echo.
echo ######## ########     ###    ##    ##  ######  ##    ##
echo ##       ##     ##   ## ##   ###   ## ##    ## ##   ##
echo ##       ##     ##  ##   ##  ####  ## ##       ##  ##
echo ######   ########  ##     ## ## ## ## ##       #####
echo ##       ##   ##   ######### ##  #### ##       ##  ##
echo ##       ##    ##  ##     ## ##   ### ##    ## ##   ##
echo ##       ##     ## ##     ## ##    ##  ######  ##    ##
echo.
echo ######## ######## ########  ##     ##    ###    ##    ##
echo ##       ##       ##     ## ###   ###   ## ##   ###   ##
echo ##       ##       ##     ## #### ####  ##   ##  ####  ##
echo ######   ######   ########  ## ### ## ##     ## ## ## ##
echo ##       ##       ##   ##   ##     ## ######### ##  ####
echo ##       ##       ##    ##  ##     ## ##     ## ##   ###
echo ##       ######## ##     ## ##     ## ##     ## ##    ##
echo.
echo Interactive Batch Script Template.
echo.
echo 0 - Help: Display information about script options.
echo 1 - Ping Utility
echo 2 - DNS Flush Utility
echo 3 - Show Date and Time
echo 4 - Assign a Network Drive
echo 9 - Exit
echo.


:inputChoice
set /p userChoice="Your choice: "
if "%userChoice%"=="9" goto quit
if "%userChoice%"=="0" goto help
if "%userChoice%"=="1" goto pingUtility
if "%userChoice%"=="2" goto flushDNS
if "%userChoice%"=="3" goto showDateTime
if "%userChoice%"=="4" goto assignNetworkDrive
echo.
echo Invalid choice, please try again.
pause
goto main


:ShowMenu
cls
echo Interactive Batch script base template.
echo.
echo 0 - Help: Display information about script options.
echo 1 - Ping Utility
echo 2 - DNS Flush Utility
echo 3 - Show Date and Time
echo 4 - Assign a Network Drive
echo 9 - Exit
goto :eof


:help
cls
echo This script serves as a base template for creating interactive batch scripts.
echo It demonstrates basic functionalities such as:
echo.
echo 0 - Help: Display this help information.
echo 1 - Ping Utility: An example function that pings a specified IP address or hostname.
echo 2 - DNS Flush Utility: An example function that flushes the DNS resolver cache.
echo 3 - Show Date and Time: An example function that displays the current system date and time.
echo 4 - Assign a Network Drive: An example function that maps a network drive to a drive letter.
echo 9 - Exit: Exits the script.
echo.
pause
goto main


:pingUtility
cls
color 7
echo ---------------------------------------
echo Ping Utility
echo ---------------------------------------
:askForIP
set "ipAddr="
set /p ipAddr="Please enter the IP address, machine name, or website to ping (e.g., 192.168.0.1 or github.com): "
if not defined ipAddr (
    echo You must enter a value.
    echo.
    goto askForIP
)
ping -a -n 4 -w 2000 -4 %ipAddr%
echo.
pause
goto main


:flushDNS
cls
color 7
echo ---------------------------------------
echo DNS Flush Utility
echo ---------------------------------------
ipconfig /flushdns
echo.
pause
goto main


:showDateTime
cls
color 7
echo ---------------------------------------
echo Current Date and Time Display
echo ---------------------------------------
echo The current system date and time is: %date% at %time%.
echo.
pause
goto main


:assignNetworkDrive
cls
color 7
echo ---------------------------------------
echo Network Drive Assignment Utility
echo ---------------------------------------
:NetworkDrive
set "NetworkDrive="
set /p NetworkDrive="Please enter the letter for the network drive: "
if not defined NetworkDrive (
    echo You must enter a drive letter.
    echo.
    goto NetworkDrive
)

:NetworkPath
echo.
set "networkPath="
set /p networkPath="Please enter the network path (e.g., \\192.168.1.10\franckferman): "
if not defined networkPath (
    echo You must enter a network path.
    echo.
    goto NetworkPath
)

:Username
echo.
set "username="
set /p username="Enter the username (domain\username or .\username for local): "
if not defined username (
    echo You must enter a username.
    echo.
    goto Username
)

:Password
echo.
set "password="
set /p password="Enter the password (input will be visible): "
if not defined password (
    echo You must enter a password or a space if none.
    echo.
    goto Password
)

echo.
echo Attempting to assign the network drive...
net use %NetworkDrive%: /delete >nul 2>&1
net use %NetworkDrive%: "%networkPath%" /user:"%username%" "%password%" /persistent:yes
if %errorlevel% == 0 (
    echo Network drive %NetworkDrive%: has been successfully assigned.
) else (
    echo Failed to assign the network drive.
)
echo.
pause
goto main


:quit
cls
color 7
exit /b
