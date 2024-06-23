cmake_minimum_required(VERSION 3.5)

project(HarmonieDaTools LANGUAGES C Fortran)

find_package (Python3 COMPONENTS Interpreter)

enable_testing()

# FORTRAN COMPILER 
if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(dialect "-ffree-form -fimplicit-none -fconvert=big-endian")
    set(bounds "-fbounds-check")
    set(ENV{CFLAGS}  " "      )  # For additional Fortran flags
    set(C_FLAGS    -Wcpp -O3 -w) # Ignore some warnings in numpy 1.7 
    add_compile_options( ${C_FLAGS} ${CFLAGS} )

endif()

if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(dialect "-free -implicitnone -convert big_endian")
    set(bounds "-check bounds")
    set(ENV{CFLAGS}  " "      )  # For additional Fortran flags 
    set(C_FLAGS    -Wcpp -O3 -w) # Ignore some warnings in numpy 1.7
    add_compile_options( ${C_FLAGS} ${CFLAGS} )

endif()

# C COMPILER 
if (CMAKE_C_COMPILER_ID MATCHES "GNU")
	set(ENV{CC}    "gcc")        # Possible to change via ENV variable
        set(ENV{CFLAGS}  " "      )  # ADDITIONAL OPTIONAL FLAGS
        set(C_FLAGS    -Wcpp -O3 -w) # Ignore some warnings in numpy 1.7
        add_compile_options( ${C_FLAGS} ${CFLAGS} )
endif()

if(CMAKE_C_COMPILER_ID MATCHES "Intel")
    set (ENV{CC}  "icc" )            # Possible to change via ENV variable
    set (ENV{CFLAGS}  ""      )
    set (ENV{C_FLAGS}  -fPIC -g  -w )
    add_compile_options(${Fortran_FLAGS} ${CFLAGS} )
endif()



set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")


#
# Compile.
#

# COMPILE THE FORTRAN ROUTINE (read stabal file for tuneBR ) 
add_subdirectory ( src )

#cmake_language(EXIT )
add_executable(jbdiagnose.x src/jbdiagnose.F90)
add_executable(cv_header_list.x src/cv_header_list.F90)
add_executable(dfscomp.x src/dfscomp.F90)
add_executable(prepdiacov.x src/prepdiacov.F90)

# install executables and scripts
install (TARGETS jbdiagnose.x
         PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ
         DESTINATION libexec)

install (TARGETS cv_header_list.x
         PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ
         DESTINATION libexec)

install (TARGETS dfscomp.x
         PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ
         DESTINATION libexec)

install (TARGETS prepdiacov.x
         PERMISSIONS OWNER_EXECUTE OWNER_WRITE OWNER_READ GROUP_EXECUTE GROUP_READ
         DESTINATION libexec)

add_subdirectory (scripts)
add_subdirectory (modules)
add_subdirectory (share)
add_subdirectory (tests)
