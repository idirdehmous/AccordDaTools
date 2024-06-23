	  #        PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ
	  #        DESTINATION modules



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

#install_modules (gsacov.py __init__.py  odb.py  setting_env.py sigma_bo.py)
