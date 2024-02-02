# 🚨 STOP! 🚨

You might want to try much simpler version of this setup, with `FetchContent`: https://github.com/lszl84/wx_cmake_fetchcontent_template

Tutorial here: https://www.youtube.com/watch?v=zjNg5HdgNO0

Or use the more complex approach described below.

# wx_cmake_template

A template for multiplatform wxWidgets projects using CMake

## How this works

This template searches for the wxWidgets library using `FindPackage`. If not found, it downloads the library source from GitHub, compiles it, and links it with the main project. 

The super build pattern with `ExternalProject_Add` is used to achieve this.

## Requirements

This works on Windows, Mac, and Linux. You'll need `cmake` and a C++ compiler (tested on `clang`, `gcc`, and MSVC).

Linux builds require the GTK3 library and headers installed in the system.

## Building

To build the project, use:

```bash
cmake -S. -Bbuild
cmake --build build
```

This will create a directory named `build` and create all build artifacts there. The main executable can be found in the `build/subprojects/Build/wx_cmake_template_core` folder.

## Using as a Template (Linux/Mac)

Use the provided `copy_to_project.sh` script to create another project from the template.

```bash
./copy_to_project.sh directory project_name
```

This will create a copy of the template's directory structure in `directory`, renaming `wx_cmake_template` to the provided `project_name`.

## Notes

For details, see the [blog post](https://www.lukesdevtutorials.com/post/wxwidgets-cmake/) and the [video](https://www.youtube.com/watch?v=MfuBS9n5_aY) tutorial showcasing the installation on Linux, Windows, and Mac OS X. 

---
Check out the blog for more! [www.lukesdevtutorials.com](https://www.lukesdevtutorials.com)
---

