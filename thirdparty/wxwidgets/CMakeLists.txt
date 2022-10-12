# check if wxWidgets is already installed in the system - using CMake's built in script FindwxWidgets
find_package(wxWidgets QUIET)

if(wxWidgets_FOUND)
    message(STATUS "Found preinstalled wxWidgets libraries at ${wxWidgets_LIBRARIES}")
    add_library(wxWidgets_external INTERFACE)
else()
    message(STATUS "Preinstalled wxWidgets not found.")
    message(STATUS "Will download and install wxWidgets in ${STAGED_INSTALL_PREFIX}")

    include(ExternalProject)
    ExternalProject_Add(wxWidgets_external
        GIT_REPOSITORY
        https://github.com/wxWidgets/wxWidgets.git
        GIT_TAG
        v3.2.1
        UPDATE_COMMAND
        ""
        CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${STAGED_INSTALL_PREFIX}
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
        -DwxBUILD_SHARED=OFF

        # Skip build step - wxWidgets CMake will build the lib during the INSTALL step
        BUILD_COMMAND
        ""

        # INSTALL_COMMAND with Release and Debug is needed for windows in order to create mswu and mswud
        # directories, required later for the Findwxwidgets.cmake script.
        # Related issue: https://github.com/wxWidgets/wxWidgets/issues/22861
        #
        # This is also safe for single configuration environments: the first command will ignore the
        # '--config' param and build a CMAKE_BUILD_TYPE configuration. The second command will skip building
        # after realizing the files are there.
        INSTALL_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> -j --target install --config Debug
        COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> -j --target install --config Release

        TEST_AFTER_INSTALL
        0
        DOWNLOAD_NO_PROGRESS
        1
        LOG_CONFIGURE
        1
        LOG_BUILD
        1
        LOG_INSTALL
        1
    )

    set(wxWidgets_ROOT_DIR ${STAGED_INSTALL_PREFIX})
    file(TO_NATIVE_PATH "${wxWidgets_ROOT_DIR}" wxWidgets_ROOT_DIR)
    set(wxWidgets_ROOT_DIR ${wxWidgets_ROOT_DIR} CACHE INTERNAL "wxWidgets installation dir")

    set(ENV_WX_CONFIG ${STAGED_INSTALL_PREFIX}/bin/wx-config)
    file(TO_NATIVE_PATH "${ENV_WX_CONFIG}" ENV_WX_CONFIG)
    set(ENV_WX_CONFIG ${ENV_WX_CONFIG} CACHE INTERNAL "wx-config dir")
endif()