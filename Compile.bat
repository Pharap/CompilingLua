::
:: Compiles Lua
::

::
:: Set up environment
::

:: Start local variable scope
@SETLOCAL

:: Locate 'vcvarsall.bat'
@IF NOT "%VS90COMNTOOLS%"=="" @SET VSVARSALL=%VS90COMNTOOLS%..\..\VC\vcvarsall.bat
@IF NOT "%VS100COMNTOOLS%"=="" @SET VSVARSALL=%VS100COMNTOOLS%..\..\VC\vcvarsall.bat
@IF NOT "%VS110COMNTOOLS%"=="" @SET VSVARSALL=%VS110COMNTOOLS%..\..\VC\vcvarsall.bat
@IF NOT "%VS120COMNTOOLS%"=="" @SET VSVARSALL=%VS120COMNTOOLS%..\..\VC\vcvarsall.bat
@IF NOT "%VS140COMNTOOLS%"=="" @SET VSVARSALL=%VS140COMNTOOLS%..\..\VC\vcvarsall.bat
@IF "%VSVARSALL%"=="" @GOTO ENDSETUP

:: Identify the target architecture
@IF NOT "%PROCESSOR_ARCHITECTURE%"=="" (
	@IF "%PROCESSOR_ARCHITECTURE%"=="x86" @SET ARCH=x86
	@IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" @SET ARCH=amd64
)
@IF "%ARCH%"=="" @GOTO ENDSCRIPT

:: Call the setup script
@CALL "%VSVARSALL%" %ARCH%
@ECHO ON

:ENDSETUP

::
:: Process files
::

:: Move down into 'src'
@PUSHD src

:: Clean up files from previous builds
@IF EXIST *.o @DEL *.o
@IF EXIST *.obj @DEL *.obj
@IF EXIST *.dll @DEL *.dll
@IF EXIST *.exe @DEL *.exe

:: Compile all .c files into .obj
@CL /MD /O2 /c /DLUA_BUILD_AS_DLL *.c

:: Rename two special files
@REN lua.obj lua.o
@REN luac.obj luac.o

:: Link up all the other .objs into a .lib and .dll file
@LINK /DLL /IMPLIB:lua.lib /OUT:lua.dll *.obj

:: Link lua into an .exe
@LINK /OUT:lua.exe lua.o lua.lib

:: Create a static .lib
@LIB /OUT:lua-static.lib *.obj

:: Link luac into an .exe
@LINK /OUT:luac.exe luac.o lua-static.lib

:: Move back up out of 'src'
@POPD

:: Copy the library and executable files out from 'src'
@COPY /Y src\lua.exe lua.exe
@COPY /Y src\luac.exe luac.exe
@COPY /Y src\lua.dll lua.dll

:ENDSCRIPT

:: End local variable scope
@ENDLOCAL