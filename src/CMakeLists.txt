cmake_minimum_required(VERSION 3.17 FATAL_ERROR)

project(wx_cmake_template_core LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# hack for buggy CMake's FindwxWidgets script
if(DEFINED ENV_WX_CONFIG)
    set(ENV{WX_CONFIG} ${ENV_WX_CONFIG})
endif()

set(wxWidgets_USE_STATIC 1)

find_package(wxWidgets COMPONENTS net base core REQUIRED CONFIG)

set(SRCS main.cpp)

if(wxWidgets_USE_FILE)
    include(${wxWidgets_USE_FILE})
endif()

if(APPLE)
    # create bundle on apple compiles
    add_executable(main MACOSX_BUNDLE ${SRCS})

    # Set a custom plist file for the app bundle - needed for Mac OS Retina display
    set_target_properties(main PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist)
else()
    # the WIN32 is needed for Windows in order for it to look for WinMain
    # instead of the main function. This is ignored on other systems,
    # so it works on all platforms
    add_executable(main WIN32 ${SRCS})
endif()

target_link_libraries(main PRIVATE ${wxWidgets_LIBRARIES})