# Compiling Lua
A guide for compiling Lua for Windows, complete with script

## Prerequisites

* A tool capable of extracting `.tar.gz` files
  * I recommend [7Zip](https://www.7-zip.org/)
* _Either_
  * A full [Visual Studio](https://visualstudio.microsoft.com/) installation
  * The [standalone Visual Studio build tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019) (unconfirmed)

## Steps

1. Go to the Lua [download area](https://www.lua.org/ftp/).
2. Download the version of Lua that you want.
3. Unzip the `.tar.gz` file using a decompression tool, giving you a folder of the form `lua-x.y.z`.
    * Where `x.y.z` corresponds to the version number of the Lua version you have downloaded, e.g. `lua-5.3.5`.
    * If you do not have a suitable decompression tool, I recommend [7Zip](https://www.7-zip.org/).
    * You may need to extract twice, once for the `.gz` wrapper and once for the `.tar` archiving.
4. Download the `Compile.bat` file from this repo and move it into the extracted `lua-x.y.z` folder.
5. Make sure you have `cl.exe`, `link.exe` and `lib.exe` either in your [`%PATH%` variable](https://en.wikipedia.org/wiki/PATH_(variable)) or in the extracted `lua-x.y.z` folder.
6. Run `Compile.bat` either by double-clicking it or running it from command line.
  * Windows may provide a security warning advising you not to run scripts from untrusted sources. If you have any doubts about whether or not you can trust the script then I advise that you _do not run it_ as I will not be held liable for any damages.
  
After step 6, there should be a copy of `lua.exe`, `luac.exe` and `lua.dll` present in the `lua-x.y.z` folder.
* `lua.exe` is the Lua interpreter, which interprets and runs scripts, and provides a Lua [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) if run without arguments.
* `luac.exe` compiles Lua files into standalone executables.
* `lua.dll` is the library file that holds all the necessary Lua pipelining and must be kept with both `lua.exe` and `luac.exe` in order for them to function correctly.

You may relocate these files as you please, as long as `lua.exe` and `luac.exe` have a copy of `lua.dll` in the same directory in which they are kept.

It is recommended that you put the directory in which these files are kept on your [`%PATH%`](https://en.wikipedia.org/wiki/PATH_(variable)) so that you can run them from the command line.
  
## Legal

The script I have provided is a modified version of the script found on [this blog](https://blog.spreendigital.de/2015/01/16/how-to-compile-lua-5-3-0-for-windows/).
I am not the original author, but I am responsible for the various modifications.
Regretably as the original script has no licence I cannot provide a licence for my modified version as I do not have proper copyright of it.
The original author retains the right to request the removal of my modified version, a request with which I would willingly (if regretfully) comply, but personally I would rather the original author added a proper licence to their original version and possibly even incorporated my modifications, as that would be a more beneficial outcome.

Regardless I will say that:
> This software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.
> In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
