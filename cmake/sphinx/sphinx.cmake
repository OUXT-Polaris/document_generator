include("${document_generator_DIR}/sphinx/FindSphinx.cmake")

function(add_package_document author)
    set(BINARY_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/doc/sphinx/_build")
    set(SPHINX_CACHE_DIR "${CMAKE_CURRENT_BINARY_DIR}/doc/sphinx/_doctrees")
    set(SPHINX_HTML_DIR "${CMAKE_CURRENT_BINARY_DIR}/doc/sphinx/html")

    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/sphinx/_static)
    
    set(AUTHOR ${author})

    configure_file(
        "${document_generator_DIR}/sphinx/conf.py.in"
        "${BINARY_BUILD_DIR}/conf.py"
        @ONLY)
        
    add_custom_target(${PROJECT_NAME}_package_document ALL
    ${SPHINX_EXECUTABLE}
        -q -b html
        -c "${BINARY_BUILD_DIR}"
        -d "${SPHINX_CACHE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}"
        "${SPHINX_HTML_DIR}"
    COMMENT "Building HTML documentation with Sphinx")

    message("targets:${TARGET_LIST}")
    

#    install(DIRECTORY ${BINARY_BUILD_DIR}
#        DESTINATION share/${PROJECT_NAME}
#    )
endfunction(add_package_document)