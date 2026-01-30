class ahb_agent extends uvm_agent;
  
  `uvm_component_utils(ahb_agent)
  
  //-------------- 	 INSTANCES ----------------//
  
  sequencer h_seqr;
  driver h_driver;
  //input_monitor h_inpmon;
  
  function new(string name="ahb_agent",uvm_component parent);
    super.new(name,parent);
		`uvm_info("ACTIVE_AGENT",$sformatf("--- ACTIVE_AGENT IS BUILT ---"),UVM_NONE);				
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_driver=driver::type_id::create("h_driver",this);
    h_seqr=sequencer::type_id::create("h_seqr",this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    h_driver.seq_item_port.connect(h_seqr.seq_item_export);
  endfunction
  
  
endclass
