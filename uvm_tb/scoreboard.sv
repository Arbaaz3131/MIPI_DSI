class scoreboard extends uvm_scoreboard;
  

  `uvm_component_utils(scoreboard)
	
  `uvm_analysis_imp_decl(_dc_mon)
  `uvm_analysis_imp_decl(_ppi_mon)
  
  uvm_analysis_imp_dc_mon #(dc_seq_item,scoreboard)dc_imp_port;

  uvm_analysis_imp_ppi_mon #(THREE_BYTES,scoreboard)ppi_imp_port;
  
  dc_seq_item dc_seqin;
  
  THREE_BYTES dc_q[$];

  THREE_BYTES dc_data,ppi_data;
  event evnt;
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    dc_imp_port=new("dc_imp_port",this);
    ppi_imp_port=new("ppi_imp_port",this);
  endfunction
  
  function write_dc_mon(dc_seq_item INDATA);
    dc_seqin=INDATA;
    dc_q.push_back(dc_seqin.pixel_data);
    //$display($time,"\t dc_q=%p",dc_q);
  endfunction

  function write_ppi_mon(THREE_BYTES PPI_DATA);
  ppi_data=PPI_DATA;
  $display("\t ++++++++ write_ppi_mon");
  ->> evnt;
  endfunction

  task run_phase(uvm_phase phase);
   forever begin
     @(evnt);
     scrb_check;
   end
  endtask


  task scrb_check;
    dc_data=dc_q.pop_front();

    if(dc_data==ppi_data)begin
      `uvm_info("SCRB_PASS",$sformatf("dc_data=%h  ppi_data=%h",dc_data,ppi_data),UVM_NONE);
    end
    else begin
      `uvm_info("SCRB_FAIL",$sformatf("dc_data=%h  ppi_data=%h",dc_data,ppi_data),UVM_NONE);
    end

  endtask

endclass
