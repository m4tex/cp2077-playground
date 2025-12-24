cmake_minimum_required(VERSION 3.31.6)

if (EXISTS "${CMAKE_SOURCE_DIR}/cmake/UserConfig.cmake")
    include("${CMAKE_SOURCE_DIR}/cmake/UserConfig.cmake")
else()
    message(FATAL_ERROR "Couldn't find user config, run cmds/bootstrap.bat, or create the file like bootstrap does.")
endif()

# CFG_PROJECT_NAME sits in project_root/cmake/UserConfig.cmake
project(${CFG_PROJECT_NAME} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PLUGINS_DIR}/${CMAKE_PROJECT_NAME})

add_subdirectory(deps/RED4ext.SDK)
set_target_properties(RED4ext.SDK PROPERTIES FOLDER "${CMAKE_SOURCE_DIR}/deps")

add_compile_definitions(NOMINMAX)
add_subdirectory(deps/RedLib)

add_library(${CMAKE_PROJECT_NAME}
        SHARED
            main.cpp
)

target_include_directories(${CMAKE_PROJECT_NAME}
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(${CMAKE_PROJECT_NAME}
        PRIVATE
        RED4ext::SDK
        RedLib
)