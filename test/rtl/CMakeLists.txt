set( CPU_TB      "${CMAKE_BINARY_DIR}/cpu_tb" )
set( ALU_TB      "${CMAKE_BINARY_DIR}/alu_tb" )
set( REGBANK_TB  "${CMAKE_BINARY_DIR}/regbank_tb" )
set( PC_CNTRL_TB "${CMAKE_BINARY_DIR}/pc_cntrl_tb" )

function( create_testbench TARGET TB_BINARY TB_SRC_FILE )
  file( GLOB RTL_SRCS
    "${TB_SRC_FILE}"
    "${RTL_SRC_DIR}/*.v"
    "${RTL_SRC_DIR}/*.vh"
  )
  add_custom_command(
    OUTPUT ${TB_BINARY}
    COMMAND iverilog -o ${TB_BINARY} -I ${RTL_SRC_DIR} -y ${RTL_SRC_DIR} ${TB_SRC_FILE}
    COMMENT "Creating ${TB_BINARY}"
    DEPENDS ${RTL_SRCS}
  )
  add_custom_target(${TARGET} ALL DEPENDS ${TB_BINARY})
endfunction(create_testbench)

create_testbench(
  cpu_testbench
  ${CPU_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}/cpu_tb.v
)
create_testbench(
  alu_testbench
  ${ALU_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}/alu_tb.v
)
create_testbench(
  regbank_testbench
  ${REGBANK_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}/regbank_tb.v
)
create_testbench(
  pc_cntrl_testbench
  ${PC_CNTRL_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}/pc_cntrl_tb.v
)
