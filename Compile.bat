::
:: Compiles Lua
::

:: Start local variable scope
@SETLOCAL

::
:: Set up environment
::

::
:: Locate 'vcvarsall.bat'
::

:: Visual Studio 2008
@IF NOT "%VS90COMNTOOLS%"=="" @SET VSVARSALL=%VS90COMNTOOLS%..\..\VC\vcvarsall.bat

:: Visual Studio 2010
@IF NOT "%VS100COMNTOOLS%"=="" @SET VSVARSALL=%VS100COMNTOOLS%..\..\VC\vcvarsall.bat

:: Visual Studio 2012
@IF NOT "%VS110COMNTOOLS%"=="" @SET VSVARSALL=%VS110COMNTOOLS%..\..\VC\vcvarsall.bat

:: Visual Studio 2013
@IF NOT "%VS120COMNTOOLS%"=="" @SET VSVARSALL=%VS120COMNTOOLS%..\..\VC\vcvarsall.bat

:: Visual Studio 2015
@IF NOT "%VS140COMNTOOLS%"=="" @SET VSVARSALL=%VS140COMNTOOLS%..\..\VC\vcvarsall.bat

:: If a known version of Visual Studio could not be found...
@IF "%VSVARSALL%"=="" (
	:: Warn the user.
	@ECHO Could not find a known Visual Studio version.

	:: Try to compile the code anyway.
	@GOTO ENDSETUP
)

:: Identify the target architecture
@IF NOT "%PROCESSOR_ARCHITECTURE%"=="" (
	:: 32-bit Systems
	@IF "%PROCESSOR_ARCHITECTURE%"=="x86" @SET ARCH=x86
	
	:: 64-bit Systems
	@IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" @SET ARCH=amd64
)

:: If the native architecture could not be identified...
@IF "%ARCH%"=="" (
	:: Log an error to the standard error stream.
	@ECHO Could not identify processor architecture. 1>&2

	:: Assume everything is going to fail and jump to the end of the script.
	@GOTO ENDSCRIPT
)

:: Call the setup script
@CALL "%VSVARSALL%" %ARCH%

:: Enable logging
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

:: Compile all .c files into .obj files
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