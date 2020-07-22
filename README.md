# document_generator

## How to use

add find_package command to the CMakeLists in the target package.(which you want to generate documentation.)
Ex:https://github.com/OUXT-Polaris/color_names/blob/09a18f15eb027f4a80e599943fded06f227d4c18/CMakeLists.txt#L25
```
find_package(document_generator REQUIRED)
```
add include command of the .cmake file to the CMakeLists in the target package.(which you want to generate documentation.)
Ex:https://github.com/OUXT-Polaris/color_names/blob/09a18f15eb027f4a80e599943fded06f227d4c18/CMakeLists.txt#L26
```
include("${document_generator_DIR}/document_generator.cmake")
```

add_document command to the build target
Ex:https://github.com/OUXT-Polaris/color_names/blob/09a18f15eb027f4a80e599943fded06f227d4c18/CMakeLists.txt#L39
```
add_document(target_name)
```

add package document command to the CMakeLists.txt
Ex:https://github.com/OUXT-Polaris/color_names/blob/09a18f15eb027f4a80e599943fded06f227d4c18/CMakeLists.txt#L54
```
add_package_document(author)
```

the documentation was installed under install directory

## Integrate with Github Actions + Github Pages
You can use github actions and github pages to write and deploy your documentation automatically.  
This github pages are deployed automatically. (https://ouxt-polaris.github.io/color_names/)  
This page was generated from thie github actions.  
You can copy and edit this workflow and deploy your documentation automatically.  
https://github.com/OUXT-Polaris/color_names/blob/master/.github/workflows/document.yaml
