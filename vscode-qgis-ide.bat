@echo off
set OSGEO4W_ROOT=C:\OSGeo4W
set PYTHONPATH=%PYTHONPATH%;%OSGEO4W_ROOT%\apps\qgis-ltr\python
set PYTHONHOME=%OSGEO4W_ROOT%\apps\Python39

@echo off
call "%OSGEO4W_ROOT%"\bin\o4w_env.bat
call "%OSGEO4W_ROOT%"\apps\grass\grass78\etc\env.bat

@echo off
path %PATH%;%OSGEO4W_ROOT%\apps\qgis-ltr\bin
path %PATH%;%OSGEO4W_ROOT%\apps\grass\grass78\lib
path %PATH%;C:\OSGeo4W3\apps\Qt5\bin
path %PATH%;C:\OSGeo4W3\apps\Python39\Scripts
path %PATH%;C:\OSGeo4W3\apps\Python39\lib

start "VSCode aware of Quantum GIS" /B "C:\Users\jirik\AppData\Local\Programs\Microsoft VS Code\Code.exe" %*
