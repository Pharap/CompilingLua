::
:: Compiles Lua
::

@REM Move down into src
@PUSHD src

@REM Clean up files from previous builds
@DEL *.obj *.o *.dll *.exe

@REM Compile all .c files into .obj
@CL /MD /O2 /c /DLUA_BUILD_AS_DLL *.c

@REM Rename two special files
@REN lua.obj lua.o
@REN luac.obj luac.o

@REM Link up all the other .objs into a .lib and .dll file
@LINK /DLL /IMPLIB:lua.lib /OUT:lua.dll *.obj

@REM Link lua into an .exe
@LINK /OUT:lua.exe lua.o lua.lib

@REM Create a static .lib
@LIB /OUT:lua-static.lib *.obj

@REM Link luac into an .exe
@LINK /OUT:luac.exe luac.o lua-static.lib

@POPD

@REM Copy the library and executable files out from 'src'
@COPY /Y src\lua.exe lua.exe
@COPY /Y src\luac.exe luac.exe
@COPY /Y src\lua.dll lua.dll