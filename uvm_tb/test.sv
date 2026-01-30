class test extends uvm_test;
  
  `uvm_component_utils(test)
  top_env h_top_env;
  DC_SEQUENCE h_dc_seq;
  ahb_sequence h_ahb_seq;

  function new(string name="",uvm_component p);
    super.new(name,p);
  endfunction
 function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_top_env=top_env::type_id::create("h_top_env",this);
    h_dc_seq=DC_SEQUENCE::type_id::create("h_dc_seq",this);
   // h_ahb_seq=ahb_master_wr_rd_sequence::type_id::create("h_ahb_seq",this);
 // uvm_config_db#(cust_svt_ahb_system_configuration)::set(this, "*", "cfg", cfg);
 

   uvm_config_db#(uvm_object_wrapper)::set(this, "h_top_env.h_ahb_env.h_active.h_seqr.run_phase", "default_sequence", ahb_sequence::type_id::get());
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
    print();
  //uvm_top.print_topology();
  endfunction
  
   task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);    
     //h_ahb_seq.start(h_top_env.h_ahb_env.ahb_system_env.master[0].sequencer);
     h_dc_seq.start(h_top_env.h_dc_env.h_dc_agt.h_dc_seqr);
     #500;
    phase.drop_objection(this);
  endtask
  
  
endclass


