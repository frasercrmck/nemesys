cmake_minimum_required( VERSION 3.5 )

function( create_testbench TARGET TB_BINARY DIR SOURCES )
  add_custom_command(
    OUTPUT ${TB_BINARY}
    COMMAND iverilog -o ${TB_BINARY} -I ${DIR} ${${SOURCES}}
    WORKING_DIRECTORY "${DIR}"
    COMMENT "Creating ${TB_BINARY}"
    DEPENDS ${${SOURCES}}
  )
  add_custom_target(${TARGET} ALL DEPENDS ${TB_BINARY})
endfunction(create_testbench)

add_subdirectory(src/rtl)
