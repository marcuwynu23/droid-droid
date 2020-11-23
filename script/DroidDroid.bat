@echo off
:===================setup configuration ===================================
set remote_path=/storage/emulated/0

set local_path=C:\Users\admin\Desktop\Dev

set working_directory=JavaNIDE

set cmdTerminal=cmd && set editorChoice=subl

set androidIDE=com.duy.compiler.javanide

set compilex=286 && set compiley=102

set runx=632 && set runy=1457

set TITLE=DroidDroidHelper

TITLE %TITLE%
Color A
:==========================================================================
:main
cd %local_path%
cls
echo    ==================================================================
echo    DroidDroidHelper (Android Development on Android Device Helper)
echo    net        connect via net(default port: 7575)
echo    usb        connect via usb
echo    ide        open ide on android
echo    cmd        open commandline Terminal
echo    e          open text Editor
echo    psa        push projects to remote android device directory
echo    pla        pull projects from remote android device directory
echo    ps         push a project to remote android device directory
echo    pl         pull a project from remote android device directory
echo    dpl        delete project in the local directory
echo    dpr        delete project in the remote directory
echo    ut         uninstall android application from android device
echo    it         install android package to the android device
echo    ra         run android application from android device
echo    ca         close android application from android device
echo    sc         save and compile 
echo    ir         install and run
echo    ==================================================================
set c=nul && set /P c=choice: 
	if %c% == tcp  goto connectViaTCP
	if %c% == usb  goto connectViaUSB
	if %c% == net  goto connectNet
	if %c% == ide  goto openIDE
	if %c% == cmd  goto openCMD
	if %c% == e    goto openEditor
	if %c% == psa  goto pushprojects
	if %c% == ps   goto pushproject
	if %c% == pla  goto pullprojects
	if %c% == pl   goto pullproject
	if %c% == dpl  goto deleteProjectLocal
	if %c% == dpr  goto deleteProjectRemote	
	if %c% == ut   goto unistallapp
	if %c% == it   goto installapp
	if %c% == ra   goto runApplication
	if %c% == ca   goto closeApplication
	if %c% == sc   goto saveCompile
	if %c% == ir   goto installRun	
	if %c% == sh   goto shell
goto main
:shell
	cls
	adb shell
goto main
:connectViaTCP
	cls
	set port=nul && set /p port=port: 
	adb tcpip %port%
goto main
:connectNet
	cls
	set ip=nul && set /p ip=ip-address: 
	set port=nul && set /p port=port: 
	adb connect %ip%:%port%
goto main
:connectViaUSB
	adb usb
goto main
:openIDE
	:: adb shell am start com.aide.ui/com.aide.ui.MainActivity > nul
	adb shell monkey -p %androidIDE% 1 > nul
goto main
:openCMD
	start %cmdTerminal%
goto main
:openEditor
	%editorChoice%
goto main
:pullprojects
	cls
	echo pull projects from %remote_path%/%working_directory%...
	adb pull %remote_path%/%working_directory% .
	echo projects pulled.
goto main
:pullproject
	cls
	set projname=nul && set /p projname=Project-name: 
	rem rmdir /S /Q %working_directory%\%projname%
	echo pull %projname% from %remote_path%/%working_directory%...
	adb pull %remote_path%/%working_directory%/%projname% %working_directory%
	echo project %projname% pulled.
goto main
:pushprojects
	cls
	echo pushing projects to remote directory...
	adb push %local_path%/%working_directory% %remote_path%
	echo projects pushed.
goto main
:pushproject
	cls
	cd %local_path%/%working_directory%
	set projname=nul && set /p projname=Project-name: 
	rem adb shell rm -rf %remote_path%/%working_directory%/%projname%
	echo pushing %projname%  to remote directory...
	adb push %projname% %remote_path%/%working_directory%
	echo project %projname% pushed.
goto main
:deleteProjectLocal
	cls
	cd %local_path%/%working_directory%
	set projname=nul && set /p projname=Project-name: 
	rmdir /Q /S %projname%
goto main
:deleteProjectRemote
	cls
	set projname=nul && set /p projname=Project-name: 
	adb shell rm -rf %remote_path%/%working_directory%/%projname%
goto main
:unistallapp
	cls
	set package=nul && set /P package=package-name: 
	adb uninstall %package%
goto askToMenu
:installapp
	cls
	set package-file=nul
	set /P package-file=package-file: 
	adb install %package-file%
goto askToMenu
:runApplication
	cls
	set package=nul && set /P package=package-name: 
	adb shell monkey -p %package% 1 > nul
goto main
:closeApplication
	cls
	set package=nul && set /P package=package-name: 
	adb shell am force-stop %package%
goto main
:saveCompile
	adb shell input tap %compilex% %compiley%
goto main
:installRun
	adb shell input tap %runx% %runy%
goto main



:askToMenu
	set back=nul
	set /P back=back to Menu[y]: 
	if %back% == y goto main
goto askToMenu
