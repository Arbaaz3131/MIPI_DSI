class ppi_agent extends uvm_agent;

  `uvm_component_utils(ppi_agent)

  ppi_monitor h_ppi_mon;

  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  h_ppi_mon=ppi_monitor::type_id::create("h_ppi_mon",this);
  endfunction

  /*
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
*/

endclass
