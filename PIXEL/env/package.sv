
`include "ahb_package_og.sv"
`include "ppi_package.sv"

package my_pkg;
`include "uvm_macros.svh"

 typedef bit[23:0]THREE_BYTES;
 import uvm_pkg::*;
  /** Import the SVT UVM Package */
 // import svt_uvm_pkg::*;

  /** Import the AHB VIP */
 // import svt_ahb_uvm_pkg::*;

  /** Import the AMBA COMMON Package for amba_pv_extension */
  //import svt_amba_common_uvm_pkg::*;
 
  import ahb_package::*;
  import ppi_pkg::*;

`include "dc_seq_item.sv"
`include "dc_sequence.sv"
`include "dc_driver.sv"
`include "dc_monitor.sv"
`include "dc_agent.sv" 
`include "scoreboard.sv"
`include "env.sv"
`include "top_env.sv"
`include "test.sv"

endpackage
