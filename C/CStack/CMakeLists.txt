cmake_minimum_required(VERSION 3.12)
project(CStack C)

set(CMAKE_C_STANDARD 99)

set(SOURCE_FILES main.c includes/stack.h includes/stack.c)

add_executable(CStack ${SOURCE_FILES})