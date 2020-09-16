
if(NOT "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitinfo.txt" IS_NEWER_THAN "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/local/bin/git"  clone --no-checkout "https://github.com/wdas/partio.git" "partio-src"
    WORKING_DIRECTORY "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/wdas/partio.git'")
endif()

execute_process(
  COMMAND "/usr/local/bin/git"  checkout v1.1.0 --
  WORKING_DIRECTORY "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'v1.1.0'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/local/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitinfo.txt"
    "/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/Users/Nathan/Desktop/PennHwork/563PhysBased/Week1/cispba/Build/Release/partio-download/partio-download-prefix/src/partio-download-stamp/partio-download-gitclone-lastrun.txt'")
endif()

