SET ( Boost_FIND_REQUIRED TRUE )
SET ( Boost_USE_MULTITHREADED ON )
SET ( Boost_USE_STATIC_LIBS OFF )
SET ( Boost_USE_STATIC_RUNTIME OFF )
SET ( CPPDB_FIND_REQUIRED TRUE )
SET ( CPPDB_SQLITE3_DRIVER_FIND_REQUIRED TRUE )
SET ( CRYPTOPP_FIND_REQUIRED TRUE )
SET ( GEOIP_FIND_REQUIRED TRUE )
SET ( GIT_FIND_REQUIRED TRUE )
SET ( GEOLITE_COUNTRY_FIND_REQUIRED TRUE )
SET ( GEOLITE_CITY_FIND_REQUIRED TRUE )
SET ( LIBB64_FIND_REQUIRED TRUE )
SET ( SQLITE3_FIND_REQUIRED TRUE )
SET ( Threads_FIND_REQUIRED TRUE )
SET ( VMIME_FIND_REQUIRED TRUE )
SET ( ZEROMQ_FIND_REQUIRED TRUE )



### Boost ###
FIND_PACKAGE (Boost 1.52.0
    COMPONENTS
        date_time filesystem iostreams system thread zlib
    )
INCLUDE_DIRECTORIES ( SYSTEM ${Boost_INCLUDE_DIRS} )
LINK_DIRECTORIES ( ${Boost_LIBRARY_DIRS} )


### CppDB ###
FIND_PACKAGE ( CppDB )
INCLUDE_DIRECTORIES ( SYSTEM ${CPPDB_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${CPPDB_LIBRARY} )


### Crypto++ ###
FIND_PACKAGE ( CryptoPP )
INCLUDE_DIRECTORIES ( SYSTEM ${CRYPTOPP_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${CRYPTOPP_LIBRARY} )


### GeoIP ###
FIND_PACKAGE ( GeoIP )
INCLUDE_DIRECTORIES ( SYSTEM ${GEOIP_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${GEOIP_LIBRARY} )


### Git ###
FIND_PACKAGE ( Git )
IF ( NOT GIT_FOUND )
    IF ( GIT_FIND_REQUIRED )
        MESSAGE ( FATAL_ERROR "Could not find Git" )
    ENDIF (  )
ENDIF (  )


### libb64 ###
FIND_PACKAGE ( LibB64 )
INCLUDE_DIRECTORIES ( SYSTEM ${LIBB64_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${LIBB64_LIBRARY} )


### Qt5 ###
IF ( BUILD_EPS_DESKTOP )
    FIND_PACKAGE( Qt5Core REQUIRED )
ENDIF (  )


### SQLite 3 ###
FIND_PACKAGE ( SQLite3 )
INCLUDE_DIRECTORIES ( SYSTEM ${SQLITE3_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${SQLITE3_LIBRARY} )


### Threads ###
FIND_PACKAGE ( Threads )
IF ( NOT Threads_FOUND )
    IF ( Threads_FIND_REQUIRED )
        MESSAGE ( FATAL_ERROR "Could not find Threads" )
    ENDIF (  )
ENDIF (  )


### VMime ###
FIND_PACKAGE ( VMime )
INCLUDE_DIRECTORIES ( SYSTEM ${VMIME_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${VMIME_LIBRARY} )


### ZeroMQ ###
FIND_PACKAGE ( ZeroMQ )
INCLUDE_DIRECTORIES ( SYSTEM ${ZEROMQ_INCLUDE_DIR} )
LINK_DIRECTORIES ( ${ZEROMQ_LIBRARY} )


