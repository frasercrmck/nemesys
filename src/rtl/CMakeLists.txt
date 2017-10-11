set( CPU_TB      "${CMAKE_BINARY_DIR}/cpu_tb" )
set( ALU_TB      "${CMAKE_BINARY_DIR}/alu_tb" )
set( REGBANK_TB  "${CMAKE_BINARY_DIR}/regbank_tb" )
set( PC_CNTRL_TB "${CMAKE_BINARY_DIR}/pc_cntrl_tb" )

set(CPU_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/cpu.v
  ${CMAKE_CURRENT_SOURCE_DIR}/alu.v
  ${CMAKE_CURRENT_SOURCE_DIR}/regbank.v
  ${CMAKE_CURRENT_SOURCE_DIR}/instr_mem.v
  ${CMAKE_CURRENT_SOURCE_DIR}/pc_cntrl.v
  ${CMAKE_CURRENT_SOURCE_DIR}/cpu_tb.v
)

set(ALU_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/alu.v
  ${CMAKE_CURRENT_SOURCE_DIR}/alu_tb.v
)

set(REGBANK_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/regbank.v
  ${CMAKE_CURRENT_SOURCE_DIR}/regbank_tb.v
)

set(PC_CNTRL_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/pc_cntrl.v
  ${CMAKE_CURRENT_SOURCE_DIR}/pc_cntrl_tb.v
)

create_testbench(
  cpu_testbench
  ${CPU_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}
  CPU_SOURCES
)
create_testbench(
  alu_testbench
  ${ALU_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ALU_SOURCES
)
create_testbench(
  regbank_testbench
  ${REGBANK_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}
  REGBANK_SOURCES
)
create_testbench(
  pc_cntrl_testbench
  ${PC_CNTRL_TB}
  ${CMAKE_CURRENT_SOURCE_DIR}
  PC_CNTRL_SOURCES
)
