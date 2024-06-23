list(APPEND br_modules
     __init__.py
     gsacov.py
     odb.py
     setting_env.py
     sigma_bo.py
)
install(PROGRAMS ${br_modules} DESTINATION modules )

foreach(module  ${br_modules})
    configure_file(${module} ${CMAKE_BINARY_DIR}/modules  COPYONLY)
endforeach()
