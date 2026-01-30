class ahb_env extends uvm_env;
  
  `uvm_component_utils(ahb_env)
  
  //-------------  HANDLES  ----------------------//
  ahb_agent h_active;
  
  function new(string name="ahb_env",uvm_component parent);
    super.new(name,parent);
		`uvm_info("ENVIRONMENT",$sformatf("--- ENVIRONMENT IS BUILT ---"),UVM_NONE);				
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_active=ahb_agent::type_id::create("h_active",this);
  endfunction

  
  
endclass
