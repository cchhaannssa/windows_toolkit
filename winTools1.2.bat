@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ============================================================================================
:: WINDOWS COMMAND & RECOVERY TOOLKIT
:: Combines the original Windows tools, networking tools, and
:: Windows recovery/diagnostic tools.
:: ============================================================================================

title Windows Command & Recovery Toolkit
color 0A

:: Report directory. A local Windows session normally uses the
:: current user's Desktop. If Desktop is unavailable, use TEMP.
set "REPORT=%USERPROFILE%\Desktop\Windows_Recovery_Reports"
if not exist "%REPORT%" md "%REPORT%" >nul 2>&1
if not exist "%REPORT%" set "REPORT=%TEMP%\Windows_Recovery_Reports"
if not exist "%REPORT%" md "%REPORT%" >nul 2>&1

:MENU
cls
echo ============================================================================================
echo              WINDOWS COMMAND ^& RECOVERY TOOLKIT
echo ============================================================================================
echo.
echo   SYSTEM / DISK TOOLS
echo   ------------------------------------------------------------------------------------------
echo   [1]  DiskPart              	[2]  Check Disk          	[3]  SFC
echo   [4]  Disk Management       	[5]  User Accounts       	[6]  Activation
echo   [7]  Command Prompt        	[8]  PowerShell          	[9]  Restart PC
echo.
echo   NETWORK / DIAGNOSTIC TOOLS
echo   ------------------------------------------------------------------------------------------
echo   [11] Wi-Fi Profiles       	[12] Wi-Fi Profile Key		[13] IP Config
echo   [14] Routing Table        	[15] DNS Lookup          	[16] ARP Cache
echo   [17] MAC / Adapter        	[18] Trace Route         	[19] NetBIOS Reset
echo   [20] NetBIOS Sessions     	[21] Netstat -f          	[22] Network View
echo   [23] Network Shares       	[24] DNS Cache           	[25] Flush DNS
echo   [26] Startup Programs     	[27] Logged-on Sessions   	[28] Running Processes
echo   [29] Processes + Paths    	[30] Installed Drivers   	[31] IP Routing Table
echo   [32] Local NetBIOS Names  	[33] Netstat -C          	[34] Wi-Fi Interface
echo   [35] Firewall Profiles    	[36] Current User        	[37] User Privileges
echo   [38] Disable Firewall
echo.
echo   WINDOWS RECOVERY / REPAIR
echo   ------------------------------------------------------------------------------------------
echo   [39] System Information   	[40] SFC Scan             	[41] SFC Verify
echo   [42] DISM Scan Health     	[43] DISM Repair Health   	[44] Component Cleanup
echo   [45] Drive Health         	[46] Reset TCP/IP        	[47] Reset Winsock
echo   [48] Battery Report       	[49] Performance Report  	[50] WinRE Information
echo   [51] System Restore       	[52] Memory Diagnostic    	[53] Advanced Startup
echo   [54] Windows Update Scan  	[55] Full Recovery Report 	[56] Exit
echo.
echo ============================================================================================
set "choice="
set /p "choice=Enter option [1-56]: "

if "%choice%"=="1" goto DISKPART
if "%choice%"=="2" goto CHKDSK
if "%choice%"=="3" goto SFC
if "%choice%"=="4" goto DISKMGMT
if "%choice%"=="5" goto USERACCOUNTS
if "%choice%"=="6" goto ACTIVATE
if "%choice%"=="7" goto CMD
if "%choice%"=="8" goto POWERSHELL
if "%choice%"=="9" goto RESTART
if "%choice%"=="10" goto EXIT
if "%choice%"=="11" goto WIFI_PROFILES
if "%choice%"=="12" goto WIFI_KEY
if "%choice%"=="13" goto IPCONFIG_ALL
if "%choice%"=="14" goto NETSTAT_R
if "%choice%"=="15" goto NSLOOKUP
if "%choice%"=="16" goto ARP
if "%choice%"=="17" goto GETMAC
if "%choice%"=="18" goto TRACERT
if "%choice%"=="19" goto NBT_RESET
if "%choice%"=="20" goto NBT_SESSIONS
if "%choice%"=="21" goto NETSTAT_F
if "%choice%"=="22" goto NET_VIEW
if "%choice%"=="23" goto NET_SHARE
if "%choice%"=="24" goto DNS_CACHE
if "%choice%"=="25" goto FLUSH_DNS
if "%choice%"=="26" goto STARTUP
if "%choice%"=="27" goto QWINSTA
if "%choice%"=="28" goto TASKLIST
if "%choice%"=="29" goto WMIC_PROCESS
if "%choice%"=="30" goto DRIVERQUERY
if "%choice%"=="31" goto ROUTE_PRINT
if "%choice%"=="32" goto NBT_NAMES
if "%choice%"=="33" goto NETSTAT_C
if "%choice%"=="34" goto WIFI_INTERFACE
if "%choice%"=="35" goto FIREWALL_SHOW
if "%choice%"=="36" goto WHOAMI
if "%choice%"=="37" goto WHOAMI_PRIV
if "%choice%"=="38" goto FIREWALL_OFF
if "%choice%"=="39" goto SYSTEMINFO
if "%choice%"=="40" goto SFC_REPAIR
if "%choice%"=="41" goto SFC_VERIFY
if "%choice%"=="42" goto DISM_SCAN
if "%choice%"=="43" goto DISM_REPAIR
if "%choice%"=="44" goto DISM_CLEANUP
if "%choice%"=="45" goto DRIVE_HEALTH
if "%choice%"=="46" goto RESET_TCPIP
if "%choice%"=="47" goto RESET_WINSOCK
if "%choice%"=="48" goto BATTERY_REPORT
if "%choice%"=="49" goto PERFORMANCE_REPORT
if "%choice%"=="50" goto WINRE_INFO
if "%choice%"=="51" goto SYSTEM_RESTORE
if "%choice%"=="52" goto MEMORY_DIAGNOSTIC
if "%choice%"=="53" goto ADVANCED_STARTUP
if "%choice%"=="54" goto WINDOWS_UPDATE
if "%choice%"=="55" goto FULL_REPORT
if "%choice%"=="56" goto EXIT

echo.
echo Invalid option. Please try again.
pause
goto MENU

:DISKPART
cls
echo ================================================================
echo DISKPART
echo ================================================================
echo Starting DiskPart. Type EXIT to return.
echo.
diskpart
goto MENU

:CHKDSK
cls
echo ================================================================
echo CHECK DISK
echo ================================================================
chkdsk
pause
goto MENU

:SFC
cls
echo ================================================================
echo SYSTEM FILE CHECKER
echo ================================================================
echo Running SFC against the currently running Windows environment.
echo.
sfc /scannow
pause
goto MENU

:DISKMGMT
cls
echo Opening Disk Management...
diskmgmt.msc
goto MENU

:USERACCOUNTS
cls
echo Opening User Accounts...
control userpasswords2
goto MENU

:ACTIVATE
cls
echo Windows/Office activation command from the original toolkit.
echo.
echo WARNING: This downloads and executes a remote PowerShell script.
echo Review the source and licensing implications before proceeding.
echo.
pause
powershell -NoProfile -NoExit -Command "irm https://get.activated.win | iex"
goto MENU

:CMD
cls
cmd
goto MENU

:POWERSHELL
cls
powershell
goto MENU

:RESTART
cls
echo Restarting computer...
shutdown /r /t 0
goto EXIT

:WIFI_PROFILES
cls
echo Saved Wi-Fi profiles:
echo.
netsh wlan show profiles
pause
goto MENU

:WIFI_KEY
cls
set "wifi="
set /p "wifi=Enter exact Wi-Fi profile name: "
if not defined wifi goto MENU
echo.
netsh wlan show profile name="%wifi%" key=clear
pause
goto MENU

:IPCONFIG_ALL
cls
ipconfig /all
pause
goto MENU

:NETSTAT_R
cls
netstat -r
pause
goto MENU

:NSLOOKUP
cls
set "host="
set /p "host=Enter hostname (default: google.com): "
if not defined host set "host=google.com"
nslookup %host%
pause
goto MENU

:ARP
cls
arp -a
pause
goto MENU

:GETMAC
cls
getmac /v
pause
goto MENU

:TRACERT
cls
set "host="
set /p "host=Enter hostname (default: google.com): "
if not defined host set "host=google.com"
tracert %host%
pause
goto MENU

:NBT_RESET
cls
nbtstat -R
pause
goto MENU

:NBT_SESSIONS
cls
nbtstat -S
pause
goto MENU

:NETSTAT_F
cls
netstat -f
pause
goto MENU

:NET_VIEW
cls
net view
pause
goto MENU

:NET_SHARE
cls
net share
pause
goto MENU

:DNS_CACHE
cls
ipconfig /displaydns
pause
goto MENU

:FLUSH_DNS
cls
ipconfig /flushdns
pause
goto MENU

:STARTUP
cls
echo Checking for WMIC startup information...
where wmic >nul 2>&1
if not errorlevel 1 (
    wmic startup get caption,command
) else (
    echo WMIC is not installed on this Windows version.
    echo Using PowerShell CIM as an alternative:
    echo.
    powershell -NoProfile -Command "Get-CimInstance Win32_StartupCommand ^| Select-Object Name,Command,Location ^| Format-Table -AutoSize"
)
pause
goto MENU

:QWINSTA
cls
qwinsta
pause
goto MENU

:TASKLIST
cls
tasklist /fi "status eq running"
pause
goto MENU

:WMIC_PROCESS
cls
where wmic >nul 2>&1
if not errorlevel 1 (
    wmic process get name,executablepath
) else (
    echo WMIC is not installed. Using PowerShell CIM instead.
    echo.
    powershell -NoProfile -Command "Get-CimInstance Win32_Process ^| Select-Object Name,ExecutablePath ^| Format-Table -AutoSize"
)
pause
goto MENU

:DRIVERQUERY
cls
driverquery /v
pause
goto MENU

:ROUTE_PRINT
cls
route -print
pause
goto MENU

:NBT_NAMES
cls
nbtstat -n
pause
goto MENU

:NETSTAT_C
cls
echo Command shown in the source video: netstat -C
echo.
netstat -C
pause
goto MENU

:WIFI_INTERFACE
cls
netsh wlan show interfaces
pause
goto MENU

:FIREWALL_SHOW
cls
netsh advfirewall show allprofiles
pause
goto MENU

:WHOAMI
cls
whoami
pause
goto MENU

:WHOAMI_PRIV
cls
whoami /priv
pause
goto MENU

:FIREWALL_OFF
cls
echo ================================================================
echo WARNING: WINDOWS FIREWALL DISABLE
echo ================================================================
echo This disables Windows Firewall for ALL profiles.
echo Only use this when you understand the security impact.
echo.
choice /c YN /n /m "Continue? [Y/N]: "
if errorlevel 2 goto MENU
netsh advfirewall set allprofiles state off
pause
goto MENU

:SYSTEMINFO
cls
echo ================================================================
echo SYSTEM INFORMATION
echo ================================================================
systeminfo
pause
goto MENU

:SFC_REPAIR
cls
echo ================================================================
echo SFC SCAN / REPAIR
 echo ================================================================
echo This scans the currently running Windows environment.
echo For offline repair from WinPE, use an offline /offwindir command.
echo.
sfc /scannow
pause
goto MENU

:SFC_VERIFY
cls
echo ================================================================
echo SFC VERIFY ONLY
 echo ================================================================
echo Checks system files without attempting repairs.
echo.
sfc /verifyonly
pause
goto MENU

:DISM_SCAN
cls
echo ================================================================
echo DISM SCAN HEALTH
 echo ================================================================
echo Scans the currently running Windows component store.
echo.
DISM /Online /Cleanup-Image /ScanHealth
pause
goto MENU

:DISM_REPAIR
cls
echo ================================================================
echo DISM RESTORE HEALTH
 echo ================================================================
echo Repairs the currently running Windows component store.
echo.
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto MENU

:DISM_CLEANUP
cls
echo ================================================================
echo COMPONENT STORE CLEANUP
 echo ================================================================
DISM /Online /Cleanup-Image /StartComponentCleanup
pause
goto MENU

:DRIVE_HEALTH
cls
echo ================================================================
echo DRIVE HEALTH
 echo ================================================================
where wmic >nul 2>&1
if not errorlevel 1 (
    wmic diskdrive get status,model,size
) else (
    echo WMIC is not installed. Using PowerShell CIM instead.
    echo.
    powershell -NoProfile -Command "Get-CimInstance Win32_DiskDrive ^| Select-Object Model,Status,@{N='SizeGB';E={[math]::Round($_.Size/1GB,1)}} ^| Format-Table -AutoSize"
)
echo.
echo Note: This is a basic Windows-reported status, not a complete SMART diagnostic.
pause
goto MENU

:RESET_TCPIP
cls
echo ================================================================
echo RESET TCP/IP
 echo ================================================================
netsh int ip reset
pause
goto MENU

:RESET_WINSOCK
cls
echo ================================================================
echo RESET WINSOCK
 echo ================================================================
netsh winsock reset
pause
goto MENU

:BATTERY_REPORT
cls
echo ================================================================
echo BATTERY REPORT
 echo ================================================================
echo Saving report to:
echo %REPORT%\battery-report.html
echo.
powercfg /batteryreport /output "%REPORT%\battery-report.html"
if exist "%REPORT%\battery-report.html" echo Report created successfully.
pause
goto MENU

:PERFORMANCE_REPORT
cls
echo ================================================================
echo PERFORMANCE REPORT
 echo ================================================================
echo Windows will collect a performance report. This may take about
 echo 60 seconds.
echo.
perfmon /report
pause
goto MENU

:WINRE_INFO
cls
echo ================================================================
echo WINDOWS RECOVERY ENVIRONMENT INFORMATION
 echo ================================================================
reagentc /info
pause
goto MENU

:SYSTEM_RESTORE
cls
echo ================================================================
echo SYSTEM RESTORE
 echo ================================================================
echo Opening the Windows System Restore interface.
echo.
rstrui.exe
goto MENU

:MEMORY_DIAGNOSTIC
cls
echo ================================================================
echo WINDOWS MEMORY DIAGNOSTIC
 echo ================================================================
echo The computer will need to restart to run the memory test.
echo.
choice /c YN /n /m "Launch Memory Diagnostic now? [Y/N]: "
if errorlevel 2 goto MENU
mdsched.exe
goto MENU

:ADVANCED_STARTUP
cls
echo ================================================================
echo ADVANCED STARTUP
 echo ================================================================
echo The computer will restart into Windows Advanced Startup options.
echo.
choice /c YN /n /m "Restart into Advanced Startup? [Y/N]: "
if errorlevel 2 goto MENU
shutdown /r /o /t 0
goto EXIT

:WINDOWS_UPDATE
cls
echo ================================================================
echo WINDOWS UPDATE SCAN
 echo ================================================================
echo This command is intended for a normal running Windows installation.
echo It may not work from WinPE or some newer Windows builds.
echo.
where usoclient.exe >nul 2>&1
if not errorlevel 1 (
    usoclient StartScan
    echo Update scan requested.
) else (
    echo UsoClient is not available on this system.
)
pause
goto MENU

:FULL_REPORT
cls
echo ================================================================
echo FULL WINDOWS RECOVERY / DIAGNOSTIC REPORT
 echo ================================================================
echo Saving report to:
echo %REPORT%
echo.

set "FULLREPORT=%REPORT%\Full_Recovery_Report.txt"
(
    echo ================================================================
    echo WINDOWS RECOVERY / DIAGNOSTIC REPORT
    echo Generated: %date% %time%
    echo Computer: %COMPUTERNAME%
    echo User: %USERNAME%
    echo ================================================================
    echo.
    echo ---------------- SYSTEM INFORMATION ----------------
    systeminfo
    echo.
    echo ---------------- WINDOWS VERSION ----------------
    ver
    echo.
    echo ---------------- SFC VERIFY ----------------
    sfc /verifyonly
    echo.
    echo ---------------- DISM COMPONENT STORE ----------------
    DISM /Online /Cleanup-Image /CheckHealth
    echo.
    echo ---------------- DISK STATUS ----------------
    where wmic >nul 2>&1
    if not errorlevel 1 (
        wmic diskdrive get status,model,size
    ) else (
        powershell -NoProfile -Command "Get-CimInstance Win32_DiskDrive ^| Select-Object Model,Status,@{N='SizeGB';E={[math]::Round($_.Size/1GB,1)}} ^| Format-Table -AutoSize"
    )
    echo.
    echo ---------------- IP CONFIGURATION ----------------
    ipconfig /all
    echo.
    echo ---------------- ROUTING TABLE ----------------
    route -print
    echo.
    echo ---------------- ARP CACHE ----------------
    arp -a
    echo.
    echo ---------------- DNS CACHE ----------------
    ipconfig /displaydns
    echo.
    echo ---------------- NETWORK CONNECTIONS ----------------
    netstat -ano
    echo.
    echo ---------------- FIREWALL ----------------
    netsh advfirewall show allprofiles
    echo.
    echo ---------------- WINRE ----------------
    reagentc /info
    echo.
    echo ---------------- CURRENT USER ----------------
    whoami
    echo.
    echo ---------------- USER PRIVILEGES ----------------
    whoami /priv
    echo.
) > "%FULLREPORT%" 2>&1

echo.
echo Report created:
echo %FULLREPORT%
echo.
start "" "%REPORT%" >nul 2>&1
pause
goto MENU

:EXIT
cls
echo ================================================================
echo Exiting Windows Toolkit...
echo ================================================================
endlocal
exit /b
