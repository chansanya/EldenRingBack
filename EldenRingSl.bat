@echo off
chcp 65001

setlocal enabledelayedexpansion

:: 备份目录
set backup_dir=%APPDATA%\EldenRing\back

:: 源文件目录
set source_dir=%APPDATA%\EldenRing

:: 如果备份目录不存在则创建
if not exist "%backup_dir%" (
  mkdir "%backup_dir%"
)

:: 得到日期
for /f "tokens=1-4 delims=/ " %%d in ("%date%") do (
  set year=%%e
  set month=%%f
  set day=%%g
)

:: 得到时间
for /f "tokens=1-3 delims=: " %%t in ("%time%") do (
  set hour=%%t
  set minute=%%u
  set second=%%v
)

::: 拼接时间搓
set timestamp=!year!!month!!day!!hour!!minute!!second:.=!

:: 备份所有指定后缀的文件到备份目录
for /r "%source_dir%" %%f in (*.txt, *.log) do (
  ::: 得到不带后缀文件名
  set "filename=%%~nf"
  ::: 生成备份临时路径
  set temp_path=!backup_dir!\!timestamp!
  ::: 不存在则创建
  if not exist "!temp_path!" (
    mkdir !temp_path!
  )
  ::: 完整备份路径
  set  back_file=!temp_path!\!filename!%%~xf

  ::: 总是已文件保存
  echo f | xcopy  "%%f" !back_file!  /y /c 
)

