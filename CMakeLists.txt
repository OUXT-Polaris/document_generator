cmake_minimum_required(VERSION 3.5)
project(document_generator)

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(Doxygen REQUIRED)

install(
  DIRECTORY cmake
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
