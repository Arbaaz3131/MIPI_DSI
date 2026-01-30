class dc_agent extends uvm_agent;
  `uvm_component_utils(dc_agent)

  dc_driver h_dc_drv;
  dc_monitor h_dc_mon;
  
  uvm_sequencer #(dc_seq_item) h_dc_seqr; 
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_dc_drv=dc_driver::type_id::create("h_d",this);
    h_dc_seqr=uvm_sequencer#(dc_seq_item)::type_id::create("h_dc_seqr",this);
    h_dc_mon=dc_monitor::type_id::create("h_dc_mon",this);
  endfunction
   
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    h_dc_drv.seq_item_port.connect(h_dc_seqr.seq_item_export);
  endfunction 

endclass
