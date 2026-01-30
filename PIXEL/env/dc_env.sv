class dc_env extends uvm_env;
  dc_agent h_dc_agt;
  
  `uvm_component_utils(dc_env)
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_dc_agt=dc_agent::type_id::create("h_dc_agt",this);
  endfunction
  
  
endclass

