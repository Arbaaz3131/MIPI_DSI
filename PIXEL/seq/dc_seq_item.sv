class dc_seq_item extends uvm_sequence_item;

  
  rand bit [23:0]pixel_data;
  rand bit pixel_valid;
  
  rand bit [31:0]active_width;
  rand bit [31:0]n_lines;
  
  rand bit[31:0]h_total,hbe,hbs;
  

  
  //number of frames
  rand bit [4:0]n_frames;

  //enum to control resolution
  typedef enum{QQVGA,QVGA,CIF,VGA,WVGA,XGA,FHP,QXGA,HD,SD,basic}resolution;
  
  rand resolution res;
  
  //enum to control modes by which no.of frames can be decided
  typedef enum{command,video}operation_mode;
  
  rand operation_mode mode;

  //constraint to control number of frames through enum "mode"  
  constraint c2{
  
    (mode==command) -> {n_frames==1;}
    (mode==video) -> {n_frames==24;}
  
  }  
  
  
  

  
   //factory registration and field macros to use core methods like print,copy and clone
  `uvm_object_utils_begin(dc_seq_item)
  `uvm_field_int(pixel_valid,  UVM_ALL_ON)
  `uvm_field_int(pixel_data,  UVM_ALL_ON)
  `uvm_field_int(active_width,       UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(n_lines,     UVM_ALL_ON| UVM_DEC)
  `uvm_field_int(h_total,    UVM_ALL_ON| UVM_DEC)  
  `uvm_field_int(n_frames,    UVM_ALL_ON)  
  `uvm_field_int(hbe,    UVM_ALL_ON)    
  `uvm_field_int(hbs,    UVM_ALL_ON)      
  `uvm_field_enum(resolution, res, UVM_ALL_ON)
  `uvm_field_enum(operation_mode,mode, UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  
  function new(input string name="dc_seq_item");
    super.new(name);
  endfunction  
  
  
  
  function void post_randomize();
    
    if(res==QQVGA)begin//{
      n_lines=120;  
      active_width=2;
      hbe=7;  //considering back porch_width=5
      h_total= 172;  //considering front porch_width=5      
      hbs=167;     // htotal- front_porch
    end//}
    
    else if(res==QVGA)begin//{
      n_lines=120;  
      active_width=2; 
      hbe=7;  //considering back porch_width=5
      h_total=172;  //considering front porch_width=5      
      hbs=167;     // htotal- front_porch      
    end//}
    
    else if(res==VGA)begin//{
      n_lines=288;  
      active_width=5;
      hbe=11;  //considering back porch_width=6
      h_total=369;  //considering front porch_width=6      
      hbs=363;     // htotal- front_porch      
    end//} 
    
    else if(res==WVGA)begin//{
      n_lines=480;  
      active_width=7;
      hbe=13;  //considering back porch_width=6 (active_width+6)
      h_total=787;  //considering front porch_width=6      
      hbs=781;     // htotal- front_porch      
    end//} 
    
    else if(res==XGA)begin//{
      n_lines=768;  
      active_width=8;
      hbe=14;  //considering back porch_width=6
      h_total=1044;  //considering front porch_width=6      
      hbs=1038;     // htotal- front_porch            
    end//} 
    
    else if(res==FHP)begin//{
      n_lines=1080;
      active_width=8; 
      hbe=14;  //considering back porch_width=6
      h_total=1940;  //considering front porch_width=6      
      hbs=1934;     // htotal- front_porch            
    end//}
    
    else if(res==QXGA)begin//{
      n_lines=1536; 
      active_width=10;  
      hbe=16;  //considering back porch_width=6
      h_total=2070;  //considering front porch_width=6      
      hbs=2064;     // htotal- front_porch            
    end//} 
    
    else if(res==HD)begin//{
      n_lines=720;
      active_width=10;
      hbe=16;  //considering back porch_width=6
      h_total=1102;  //considering front porch_width=6      
      hbs=1096;     // htotal- front_porch      
    end//} 
    
    else if(res==basic)begin//{
      n_lines=10;
      active_width=10;
      hbe=15;  //considering back porch_width=5
      h_total=50;  //considering front porch_width=5      
      hbs=45;     // htotal- front_porch      
    end//}  
    
  endfunction
  
  
  
  
  
endclass

