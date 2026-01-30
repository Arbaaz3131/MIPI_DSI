interface ppi_intf(input bit ppi_clk);
  logic [7:0]	ppi_data_lane0;
  logic [7:0]	ppi_data_lane1;
  logic [7:0]	ppi_data_lane2;
  logic [7:0]	ppi_data_lane3;
  logic			ppi_lane0_en;
  logic 		ppi_lane1_en;
  logic			ppi_lane2_en;
  logic			ppi_lane3_en;

  clocking cb_monitor@(posedge ppi_clk);
    input ppi_data_lane0,ppi_data_lane1,ppi_data_lane2,ppi_data_lane3;
    input ppi_lane0_en,ppi_lane1_en,ppi_lane2_en,ppi_lane3_en;
  endclocking


endinterface
