class top_env extends uvm_env;

  `uvm_component_utils(top_env)

  ahb_env h_ahb_env;
  dc_env h_dc_env;
  ppi_env h_ppi_env;

  scoreboard h_scrb; 
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_ahb_env=ahb_env::type_id::create("h_ahb_env",this);
    h_dc_env=dc_env::type_id::create("h_dc_env",this);
    h_ppi_env=ppi_env::type_id::create("h_ppi_env",this);
    h_scrb=scoreboard::type_id::create("h_scrb",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);  
    h_dc_env.h_dc_agt.h_dc_mon.dc_analysis_port.connect(h_scrb.dc_imp_port);
    h_ppi_env.h_ppi_agent.h_ppi_mon.ppi_port.connect(h_scrb.ppi_imp_port);
  endfunction


endclass
