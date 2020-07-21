find_package(Doxygen REQUIRED)

function(add_document target)
    set(TARGET_LIST ${TARGET_LIST} ${target} PARENT_SCOPE)

    get_property(sourcefiles
        TARGET ${target}
        PROPERTY SOURCES)
        foreach (source ${sourcefiles})
            set(source_spaces "${source_spaces} ${PROJECT_SOURCE_DIR}/${source}")
        endforeach ()
    set(includedirs ${CMAKE_CURRENT_SOURCE_DIR}/include)

    file(GLOB_RECURSE headers ${includedirs}/*.h)
    foreach (h ${headers})
        set(header_spaces "${header_spaces} ${h}")
    endforeach ()
    file(GLOB_RECURSE headers_hh ${includedirs}/*.hh)
    foreach (h ${headers_hh})
        set(header_spaces "${header_spaces} ${hh}")
    endforeach ()
    file(GLOB_RECURSE headers_hh ${includedirs}/*.hpp)
    foreach (h ${headers_hpp})
        set(header_spaces "${header_spaces} ${hpp}")
    endforeach ()
    foreach (dir ${includedirs})
        set(dir_spaces "${dir_spaces} ${dir}")
    endforeach ()
    get_property(definitions
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        PROPERTY COMPILE_DEFINITIONS)
    foreach (def ${definitions})
        set(predef_spaces "${predef_spaces} ${def}")
    endforeach ()

    set(output_path ${CMAKE_CURRENT_BINARY_DIR}/doc/${target})

    file(MAKE_DIRECTORY ${output_path})

    add_custom_command(
        OUTPUT  ${output_path}/doxygen/Doxyfile
        COMMAND ${CMAKE_COMMAND}
                -D "DOXYGEN_TEMPLATE=${document_generator_DIR}/doxygen/Doxyfile.in"
                -D "DOXY_PROJECT_INPUT=${source_spaces} ${header_spaces}"
                -D "DOXY_PROJECT_INCLUDE_DIR=${dir_spaces}"
                -D "DOXY_PROJECT_PREDEFINED=${predef_spaces}"
                -D "DOXY_PROJECT_STRIP_FROM_PATH=${PROJECT_SOURCE_DIR}"
                -D "DOXY_DOCUMENTATION_OUTPUT_PATH=${output_path}"
                -D "DOXY_PROJECT_NAME=${target}"
                -P "${document_generator_DIR}/doxygen/doxygen-script.cmake"
        DEPENDS ${document_generator_DIR}/doxygen/Doxyfile.in
                ${output_path}
        WORKING_DIRECTORY
                ${output_path}
        COMMENT "Generating Doxyfile for ${target}")

    add_custom_command(
        OUTPUT  ${output_path}/doxygen/index.html
        COMMAND ${DOXYGEN_EXECUTABLE}
        DEPENDS ${output_path}/doxygen/Doxyfile
        WORKING_DIRECTORY
                ${output_path}/doxygen
        COMMENT "Creating HTML documentation for ${target}")

    add_custom_target("doxygen-${PROJECT_NAME}-${target}" ALL
        DEPENDS ${output_path}/doxygen/index.html)

    set(image_source_dir ${PROJECT_SOURCE_DIR}/img)
    set(image_dir ${output_path}/${target}/html/images)
    file(GLOB images_png ${image_source_dir}/*.png)
    file(GLOB images_jpg ${image_source_dir}/*.jpg)
    file(GLOB images_jpeg ${image_source_dir}/*.jpeg)
    message("images : ${images_png} ${images_jpg} ${images_jpeg}")
    foreach (img ${images_png})
        file(COPY ${img} DESTINATION ${image_dir})
        set(image_spaces "${image_spaces} ${img}")
    endforeach ()
    foreach (img ${images_jpg})
        file(COPY ${img} DESTINATION ${image_dir})
        set(image_spaces "${image_spaces} ${img}")
    endforeach ()
    foreach (img ${images_jpeg})
        file(COPY ${img} DESTINATION ${image_dir})
        set(image_spaces "${image_spaces} ${img}")
    endforeach ()
endfunction()