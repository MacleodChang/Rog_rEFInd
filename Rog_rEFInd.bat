@echo off

REM Switch to Administrator
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

mountvol S: /S

xcopy /E /Y rEFInd S:\EFI\rEFInd\
bcdedit /set "{bootmgr}" path \EFI\rEFInd\refind_rog.efi
bcdedit /set "{bootmgr}" description "rEFInd"

mountvol S: /D


REM Set UTC Timezone - Dual-Boot time fix
reg add "HKLM\System\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /d 1 /t REG_DWORD /f

pause

