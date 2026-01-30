class ppi_seq_item extends uvm_sequence_item;

  `uvm_object_utils(ppi_seq_item)
  
  bit [7:0]	ppi_data_lane0;
  bit [7:0]	ppi_data_lane1;
  bit [7:0]	ppi_data_lane2;
  bit [7:0]	ppi_data_lane3;
  bit	        ppi_lane0_en;
  bit 		ppi_lane1_en;
  bit           ppi_lane2_en;
  bit		ppi_lane3_en;


  function new(string name="");
    super.new(name);
  endfunction






endclass
