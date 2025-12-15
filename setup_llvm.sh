#!/bin/bash

# Configuration
LLVM_VERSION="21.1.7"
LLVM_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/clang+llvm-${LLVM_VERSION}-x86_64-pc-windows-msvc.tar.xz"
ARCHIVE_NAME="llvm.tar.xz"
EXTRACTED_DIR="clang+llvm-${LLVM_VERSION}-x86_64-pc-windows-msvc"
TARGET_DIR="llvm"
CMAKE_FILE="CMakeLists.txt"

# 1. Download LLVM
if [ ! -d "$TARGET_DIR" ]; then
    echo "Downloading LLVM ${LLVM_VERSION}..."
    curl -L -o "$ARCHIVE_NAME" "$LLVM_URL"

    if [ $? -ne 0 ]; then
        echo "Download failed."
        exit 1
    fi

    # 2. Extract
    echo "Extracting LLVM..."
    tar -xf "$ARCHIVE_NAME"

    if [ $? -ne 0 ]; then
        echo "Extraction failed."
        exit 1
    fi

    # 3. Rename and Cleanup
    echo "Setting up directory..."
    rm "$ARCHIVE_NAME"
    mv "$EXTRACTED_DIR" "$TARGET_DIR"
else
    echo "LLVM directory already exists. Skipping download."
fi

# 4. Configure CMakeLists.txt
echo "Configuring $CMAKE_FILE..."

cat > "$CMAKE_FILE" <<EOL
cmake_minimum_required(VERSION 3.20)

project(requitec_workspace LANGUAGES CXX)

# Set the path to the local LLVM installation
set(CMAKE_PREFIX_PATH "\${CMAKE_CURRENT_SOURCE_DIR}/llvm" CACHE PATH "Path to LLVM installation")

add_subdirectory(requitec)
EOL

echo "Done! You can now generate the project with:"
echo "cmake -B build"
