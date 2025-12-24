cmake_minimum_required(VERSION 3.31.6)
project(Netrunner LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

if (EXISTS "${CMAKE_SOURCE_DIR}/cmake/UserConfig.cmake")
    include("${CMAKE_SOURCE_DIR}/cmake/UserConfig.cmake")
else()
    message(FATAL_ERROR "Couldn't find user config, run cmds/bootstrap.bat, or create the file like bootstrap does.")
endif()

add_subdirectory(deps/RED4ext.SDK)
set_target_properties(RED4ext.SDK PROPERTIES FOLDER "${CMAKE_SOURCE_DIR}/deps")

add_compile_definitions(NOMINMAX)
add_subdirectory(deps/RedLib)

add_library(playground
        SHARED
            main.cpp
)

target_include_directories(playground
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}
)