class dc_monitor extends uvm_monitor;
  
  `uvm_component_utils(dc_monitor)
  
  virtual inter intf;
  dc_seq_item h_seqitem; 
  uvm_analysis_port #(dc_seq_item)dc_analysis_port;
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    h_seqitem=dc_seq_item::type_id::create("h_seqitem",this);
    uvm_config_db #(virtual inter)::get(this,"*","intf",intf);  
    dc_analysis_port=new("dc_analysis_port",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever@(intf.cb_monitor)begin//{ 1
      h_seqitem.pixel_valid=intf.pixel_valid;
      h_seqitem.pixel_data=intf.pixel_data;
      
      if(h_seqitem.pixel_valid)begin//{2
        dc_analysis_port.write(h_seqitem);
        `uvm_info("MONITOR_DATA",$sformatf("  pixel_data=%d",h_seqitem.pixel_data),UVM_DEBUG);
      end//} 2
      
    end//}1
  endtask
  
endclass
