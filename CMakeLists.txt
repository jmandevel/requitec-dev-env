cmake_minimum_required(VERSION 3.20)

project(requitec_workspace LANGUAGES CXX)

# Set the path to the local LLVM installation (Windows only default, and only for Release)
if(WIN32)
    if (CMAKE_BUILD_TYPE STREQUAL "Release")
        set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/llvm" CACHE PATH "Path to LLVM installation")
    else()
        message(FATAL_ERROR "Debug builds on Windows are not supported. Please use Release mode (-DCMAKE_BUILD_TYPE=Release) or use WSL.")
    endif()
endif()

add_subdirectory(requitec)
