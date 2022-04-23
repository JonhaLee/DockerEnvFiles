set(CMAKE_C_COMPILER "/usr/bin/clang-12")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++-12")

project(DockerBuildEnvTEst)

cmake_minimum_required(VERSION 3.16)

add_executable(Main src/main.cpp)