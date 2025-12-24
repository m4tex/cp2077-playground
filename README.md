# cp2077-playground
Base project with RED4ext and RedLib in CMake. Comes with a batch script for automatic setup. Has a folder for redscript 
files which get compiled.
## Setup
In admin privileged command prompt, run
```
git clone https://github.com/m4tex/cp2077-playground
./cp2077-playground/cmds/setup.bat
```
If in doubt, feel free to see why admin privileges are required in the batch script (for creating symlinks).

Build the library using the MSVC toolchain. For running tests, you can add these program arguments to the game executable
`--skip-launcher -modded -skipStartScreen -noWatermark`