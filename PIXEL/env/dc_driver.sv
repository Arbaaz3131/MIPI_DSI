class dc_driver extends uvm_driver #(dc_seq_item);
  
  `uvm_component_utils(dc_driver)
  virtual inter intf;


  
  function new(string name="dc_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db #(virtual inter)::get(this,"*","intf",intf);
  endfunction
  
  
  task run_phase(uvm_phase phase);
    seq_item_port.get_next_item(req);    
    frame_info_drive;
    seq_item_port.item_done();
    req.print();
  endtask
  
  
task vsync_high;
  repeat(req.active_width)begin//{
    @(intf.cb_driver);
    intf.vsync<=1;
  end//}
  @(intf.cb_driver) intf.vsync<=0;  //recheck
endtask


task hsync_high;
  for(int h;h<req.n_lines;h++)begin//{1
    
    //active hsync region
    repeat(req.active_width)begin//{2
      @(intf.cb_driver);
      intf.hsync<=1;
      intf.pixel_valid<=0;
      intf.pixel_data<=0;      
    end//}2

    //region except active_hsync
    repeat(req.h_total-req.active_width)begin//{3
      @(intf.cb_driver);
      intf.hsync<=0;      
    end//}3
    
  end//}1
  
endtask




task data_drive;
  for(int d;d<req.n_lines;d++)begin//{1

    // active_region+back_porch
    repeat(req.hbe)begin//{1
      @(intf.cb_driver);
      intf.pixel_data<=0;
      intf.pixel_valid<=0;
    end//}1
  
    //active time for data driving 
    repeat(req.hbs-req.hbe)begin//{2
      @(intf.cb_driver);
      intf.pixel_data<=$urandom;      //change it to $urandom if needed
      intf.pixel_valid<=1;
      `uvm_info("DRIVER_DATA",$sformatf(" pixel_data=%d",intf.pixel_data),UVM_LOW);
    end//}2
    
    //front_porch time     
    repeat(req.h_total-req.hbs)begin//{3
      @(intf.cb_driver);
      intf.pixel_data<=0;
      intf.pixel_valid<=0;      
    end//}3

    
  end//}1
  
endtask


task frame_info_drive;
  
  for(int f;f<req.n_frames;f++)begin//{
    fork
      vsync_high;
      hsync_high;
	  data_drive;      
    join
  end//}
  
endtask
  
  
endclass
