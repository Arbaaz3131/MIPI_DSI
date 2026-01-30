package ppi_pkg;
`include "uvm_macros.svh"
 typedef bit[23:0]THREE_BYTES;

 import uvm_pkg::*;
  `include "ppi_seq_item.sv"
  `include "ppi_monitor.sv"
  `include "ppi_agent.sv"
  `include "ppi_env.sv"
 
endpackage
