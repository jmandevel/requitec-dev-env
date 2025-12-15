cmake_minimum_required(VERSION 3.20)

project(requitec_workspace LANGUAGES CXX)

# Set the path to the local LLVM installation
set(CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/llvm" CACHE PATH "Path to LLVM installation")

add_subdirectory(requitec)
