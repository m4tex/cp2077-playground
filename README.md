# cp2077-playground
Base project with RED4ext and RedLib in CMake. Comes with a batch script for automatic setup. Has a folder for redscript 
files which get compiled.
## Setup
```
git clone https://github.com/m4tex/cp2077-playground
```
Run `cmds/setup.bat` as administrator.
If in doubt, feel free to see why admin privileges are required in the batch script (for creating symlinks).

All files and directories in `res/` will be symlinked to the plugin directory when you first run setup.bat. You can run
the generated `symlink.bat` to create symlinks to any new files in the res folder.

Finally, you can put `.reds` files into `res/scripts` and they will be compiled at runtime.

Build the library using the MSVC toolchain. For running tests, you can add these program arguments to the game 
executable `--skip-launcher -modded -skipStartScreen -noWatermark`