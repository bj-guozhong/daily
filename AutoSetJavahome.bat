@echo off

:: TODO:设置java环境变量
:: Author: ZGZ
color 02
::设置java的安装路径，可方便切换不同的版本

set home4=%%JAVA_HOME4%%
set home6=%%JAVA_HOME6%%
set home8=%%JAVA_HOME8%%
set javaPath=%home8% 

set input=
set /p "input=请输入java的jdk版本(4或6或8):"
if %input% == 8 (
	set javaPath=%home8%
	echo jdk已设置为1.8
)else if %input% == 4 (
	set javaPath=%home4%
	echo jdk已设置为1.4
)else if %input% == 6 (
	set javaPath=%home6%
	echo jdk已设置为1.6
)else (
	set javaPath=%home8%
	echo jdk已默认1.8
)
::如果有的话，先删除JAVA_HOME
::wmic ENVIRONMENT where "name='JAVA_HOME'" delete

::创建JAVA_HOME
::wmic ENVIRONMENT create name="JAVA_HOME",username="<system>",VariableValue="%javaPath%"
wmic ENVIRONMENT where "name='JAVA_HOME' and username='<system>'" set VariableValue="%javaPath%"
echo 设置成功,当前JDK版本为%javaPath%

taskkill /im explorer.exe /f
@echo ================================================
@echo 下面开始重启“explorer.exe”进程
pause
start explorer.exe