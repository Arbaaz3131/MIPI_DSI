class ppi_env extends uvm_env;


 `uvm_component_utils(ppi_env)
  ppi_agent h_ppi_agent;
 
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  h_ppi_agent=ppi_agent::type_id::create("h_ppi_agent",this);
  endfunction

endclass
