class ppi_monitor extends uvm_monitor;

  `uvm_component_utils(ppi_monitor)

  virtual ppi_intf p_intf;
  uvm_analysis_port #(THREE_BYTES) ppi_port;
  ppi_seq_item h_seqitem;
  bit [31:0]byte_count;
  bit [15:0]word_count;


  bit [7:0]data_q[$];
  THREE_BYTES payload;

  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  uvm_config_db #(virtual ppi_intf)::get(this,"","p_intf",p_intf);
  h_seqitem=ppi_seq_item::type_id::create("h_seqitem");
  ppi_port=new("ppi_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    forever@(p_intf.cb_monitor)begin//{
      h_seqitem.ppi_data_lane0=p_intf.ppi_data_lane0;
      h_seqitem.ppi_data_lane1=p_intf.ppi_data_lane1;
      h_seqitem.ppi_data_lane2=p_intf.ppi_data_lane2;
      h_seqitem.ppi_data_lane3=p_intf.ppi_data_lane3;
      h_seqitem.ppi_lane0_en=p_intf.ppi_lane0_en;
      h_seqitem.ppi_lane1_en=p_intf.ppi_lane1_en;
      h_seqitem.ppi_lane2_en=p_intf.ppi_lane2_en;
      h_seqitem.ppi_lane3_en=p_intf.ppi_lane3_en;
      data_push();
      data_send();
      `uvm_info("PPI_MON_Q",$sformatf("\t +++++++++++++++++++++  data_q=%p",data_q),UVM_NONE);
    end//}
  endtask

  task data_push;    
    if(h_seqitem.ppi_lane0_en)begin
      byte_count++;
      depacketize(h_seqitem.ppi_data_lane0);
    end
    else begin
      byte_count=0;
    end
   
    if(h_seqitem.ppi_lane1_en)begin
      byte_count++;
      depacketize(h_seqitem.ppi_data_lane1);
    end
   
    if(h_seqitem.ppi_lane2_en)begin
      byte_count++;
      depacketize(h_seqitem.ppi_data_lane2);
    end
   
    if(h_seqitem.ppi_lane3_en)begin
      byte_count++;
      depacketize(h_seqitem.ppi_data_lane3);
    end
  endtask

  
  task data_send;
    
    if(data_q.size>=3)begin//{1
      payload={data_q[2],data_q[1],data_q[0]};
      ppi_port.write(payload);
      `uvm_info("PIXEL_COUNT .write",$sformatf("\t +++++++++++++++++++++  data_q=%p",data_q),UVM_NONE);
      for(int i=0;i<3;i++)begin//{2
	data_q.delete(0);
      end//}2    
    end//}1
  
  endtask


  task depacketize(bit [7:0]payld_data);
 
 
 
  if(byte_count==28)begin//{
    word_count[7:0]=payld_data;
  end//}
  if(byte_count==29)begin//{
    word_count[15:8]=payld_data;
      `uvm_info("word_count",$sformatf("\t +++++++++++++++++++++  word_count=%d",word_count),UVM_NONE);
  end//}

    if(byte_count>30 && byte_count<=30+(90))begin//{
    data_q.push_back(payld_data);
  end//}
  endtask


endclass
