class DC_SEQUENCE extends uvm_sequence #(dc_seq_item);
   
  `uvm_object_utils(DC_SEQUENCE)

  function new(input string name="seq");
    super.new(name);
  endfunction  

  task body();
    req=dc_seq_item::type_id::create("dc_seq_item");
    start_item(req);
    req.randomize() with {res==basic;mode==command;};
    finish_item(req);
  endtask  
  
endclass
  



