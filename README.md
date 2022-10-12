# wx_cmake_template

A template for multiplatform WxWidgets projects using CMake.

This is now updated to work with wxWidgets 3.2.1. If you need the 3.1.4 version (also desribed in https://www.youtube.com/watch?v=MfuBS9n5_aY&t=4s), check out the v3.1.4 tag.

The CMake build script looks for installed wxWidgets using *find_package*. If the library is not found, it downloads wxWidgets from GitHub, builds it from source and links to the program in *src/main.cpp*. 

Thus you can build a desktop app on any platform (Windows/Mac/Linux) without downloading the UI Library. Linux requires the gtk3-dev though.

The repository also includes launch tasks for each platform to be used with Visual Studio Code. Just choose the correct configuration and hit F5 - vscode will build the Debug configuration and launch your program.

**Note:** for single configuration environments (e.g. the default *make* on Mac and Linux) if you want to build both Debug and Release configurations, or switch between them, you'd need to delete the *build* directory before changing configurations, otherwise the script will link to the previously built version of the wxWidgets library. This is due to the behavior of CMake's Findwxwidgets script which will stubbornly search the *build* dir.

So, build the first configuration:
```
$ cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Debug
$ cmake --build build
```
Move the build artifacts to somewhere safe
```
$ mv build/subprojects/wx_cmake_template_core/ ~/somewhere/safe/
```
Remove the build dir and repeat with the other configuration (*Release* in this case):
```
$ cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
$ cmake --build build
[etc etc...]
```

For multi configuration environments (e.g. **Windows with MSVC**) this is not needed, just invoke the two build commands:

```
> cmake -S. -Bbuild
> cmake --build build --config Debug
> cmake --build build --config Release
```

CMake will build both variants in separate directories.