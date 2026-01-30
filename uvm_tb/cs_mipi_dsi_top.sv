import uvm_pkg::*;
`include "uvm_macros.svh"
`include "package.sv"

`include "dc_interface.sv"
`include "ahb_interface.sv"
`include "ppi_interface.sv"

  
import my_pkg::*;


module cs_mipi_dsi_top;
  bit clk,rst;
  bit ahb_clk,dsi_clk;

  always #5 clk=~clk;
  always #5 ahb_clk=~ahb_clk;
  
  inter intf(clk);
  svt_ahb_if ahb_intf(ahb_clk);
  ppi_intf p_intf(dsi_clk);
  
  assign ahb_intf.HRESETn = rst;

  dsi #(30,10)uut(.vsync(intf.vsync),
                 .hsync(intf.hsync),
                 .pixel_data(intf.pixel_data),
                 .data_valid(intf.pixel_valid),
                 .hprot(ahb_intf.HPROT), 
                 .haddr(ahb_intf.HADDR),
        .hsize(ahb_intf.HSIZE),
        .htrans(ahb_intf.HTRANS),
        .hburst(ahb_intf.HBURST),
        .hwrite(ahb_intf.HWRITE),
        .hwdata(ahb_intf.HWDATA),
        .hready(ahb_intf.HREADY),
        .hresp(ahb_intf.HRESP),
        .hrdata(ahb_intf.HRDATA),
                 .pclk(clk),
                 .dsi_clk(dsi_clk),
        .dsi_rst(rst),
        .ppi_data_lane0(p_intf.ppi_data_lane0),
        .ppi_data_lane1(p_intf.ppi_data_lane1),
        .ppi_data_lane2(p_intf.ppi_data_lane2),
        .ppi_data_lane3(p_intf.ppi_data_lane3),
        .ppi_lane0_en(p_intf.ppi_lane0_en),
        .ppi_lane1_en(p_intf.ppi_lane1_en),
        .ppi_lane2_en(p_intf.ppi_lane2_en),
        .ppi_lane3_en(p_intf.ppi_lane3_en)
       
       );
  initial begin
    uvm_config_db #(virtual inter)::set(null,"*","intf",intf);
    uvm_config_db #(virtual svt_ahb_if)::set(null,"*","vif",ahb_intf);
    uvm_config_db #(virtual ppi_intf)::set(null,"*","p_intf",p_intf);    
    run_test("test"); 
  end
  initial begin  
    rst=0;
    #100;
    rst=1;
  end
  initial begin
   $dumpfile("dump.vcd");
   $dumpvars;
  end

///*
  initial begin
    #1000;
    $display($time,"\t ====== register=%p ============",uut.dsi_reg);
  end
  
//*/
  
endmodule
