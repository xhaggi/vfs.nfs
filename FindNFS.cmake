#.rst:
# FindNFS
# -------
# Finds the libnfs library
#
# This will will define the following variables::
#
# NFS_FOUND - system has libnfs
# NFS_INCLUDE_DIRS - the libnfs include directory
# NFS_LIBRARIES - the libnfs libraries
# NFS_DEFINITIONS - the libnfs compile definitions

if(PKG_CONFIG_FOUND)
  pkg_check_modules(PC_NFS libnfs QUIET)
endif()

find_path(NFS_INCLUDE_DIR nfsc/libnfs.h
                          PATHS ${PC_NFS_INCLUDEDIR})

set(NFS_VERSION ${PC_NFS_VERSION})

include(FindPackageHandleStandardArgs)

find_library(NFS_LIBRARY NAMES nfs libnfs
                         PATHS ${PC_NFS_LIBDIR})

find_package_handle_standard_args(NFS
                                  REQUIRED_VARS NFS_LIBRARY NFS_INCLUDE_DIR
                                  VERSION_VAR NFS_VERSION)

if(NFS_FOUND)
  set(NFS_LIBRARIES ${NFS_LIBRARY})
  if(WIN32)
    list(APPEND NFS_LIBRARIES ws2_32)
  endif()
  set(NFS_INCLUDE_DIRS ${NFS_INCLUDE_DIR})
  set(NFS_DEFINITIONS -DHAVE_LIBNFS=1)
endif()

mark_as_advanced(NFS_INCLUDE_DIR NFS_LIBRARY)
