@echo off
color 0A
if not exist "C:\Fileshare\" mkdir "C:\Fileshare"
hostname
hostname > C:\IP-MAC.txt
ipconfig /all | findstr IPv4
ipconfig /all | findstr IPv4 >> C:\IP-MAC.txt
ipconfig /all | findstr Physical
ipconfig /all | findstr Physical >> C:\IP-MAC.txt
echo.
echo.
echo.

echo Disabling Administrative Shares

REG ADD HKEY_LOCAL_MACHINESYSTEMCurrentControlSetservicesLanmanServerParameters /f /v AutoShareWks /t REG_SZ /d 0

echo Configuring audit policy

echo Process Tracking: Success & Failure
auditpol /set /category:"Detailed Tracking" /Success:enable /failure:enable

echo Account Management: Success & Failure
auditpol /set /category:"Account Management" /Success:enable /failure:enable

echo Audit directory service access: Success & Failure
auditpol /set /category:"DS access" /Success:enable /failure:enable

echo Logon Events: Success & Failure
auditpol /set /category:"Logon/Logoff" /Success:enable /failure:enable
echo Account Logon Events: Success & Failure
auditpol /set /category:"Account Logon" /Success:enable /failure:enable

echo Audit object access: Success & Failure
auditpol /set /category:"Object access" /Success:enable /failure:enable

echo Audit policy change: Success & Failure
auditpol /set /category:"Policy change" /Success:enable /failure:enable

echo Audit privilege use: Success & Failure
auditpol /set /category:"Privilege use" /Success:enable /failure:enable

echo Audit system events: Success & Failure
auditpol /set /category:"System" /Success:enable /failure:enable

echo.
echo.
echo.
color 0A
echo Displaying Completed Audit Policy
auditpol /get /category:*
auditpol /get /category:* > C:\AuditPolicy.txt
echo.
echo.
echo.
color 0B

echo Displaying Scheduled Tasks
schtasks /Query
schtasks /Query > C:\ScheduledTasks.txt
echo.
echo.
echo.
echo Changing Color For Visibility
color 0A

::Block All Incoming Ports Script
echo @echo off > C:\Block_All_Ports.bat
echo netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound >> C:\Block_All_Ports.bat
echo exit >> C:\Block_All_Ports.bat
::Enable ICMP Script
echo @echo off > C:\Enable_ICMP.bat
echo netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow >> C:\Enable_ICMP.bat
echo netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol=icmpv6:8,any dir=in action=allow >> C:\Enable_ICMP.bat
echo exit >> C:\Enable_ICMP.bat
::Disable ICMP Script
echo @echo off > C:\Disable_ICMP.bat
echo netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=block >> C:\Disable_ICMP.bat
echo netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol=icmpv6:8,any dir=in action=block >> C:\Disable_ICMP.bat
echo exit >> C:\Disable_ICMP.bat
echo Opening Task Manager To Inspect Processes & Services
start taskmgr
echo.

echo COMPLETED
echo TOOL BY: Gurpreet Singh
pause