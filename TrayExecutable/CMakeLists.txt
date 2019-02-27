cmake_minimum_required(VERSION 3.9)
project(UnifiedRemote C)

set(CMAKE_C_STANDARD 11)

add_executable(UnifiedRemote main.c VoicemeeterRemote.h)