class axi_lite_master_sequence extends uvm_sequence #(axi_lite_item);

    `uvm_object_utils(axi_lite_master_sequence)

    axi_lite_item master_sequence_item;

    rand int seq_count;
    int seq_count_min;
    int seq_count_max;

    constraint cnstr_seq {
        seq_count inside {[seq_count_min : seq_count_max]};
    };

    function new(string name = "axi_lite_master_sequence");
        super.new(name);
    endfunction: new

    virtual task body();
        repeat (seq_count) begin
            master_sequence_item = axi_lite_item::type_id::create("master_sequence_item");
            start_item(master_sequence_item);
            if (!master_sequence_item.randomize()) begin
                `uvm_error({get_full_name(), "MASTER SEQUENCE"}, "Randomize failed")
            end
            finish_item(master_sequence_item);
        end
        `uvm_info(get_name(), "seqe ends\n", UVM_NONE)
    endtask: body

    function void pre_randomize();
        string str_cfg;
        string str_out_cfg;
        str_cfg = {str_cfg, $sformatf("Randomize sequence counter = %2d", seq_count)};
        str_out_cfg = $sformatf("%s\n", str_cfg);
        `uvm_info ("PRE_RANDOMIZE", $sformatf("SEQUENCE PRE CONFIG: %s", str_out_cfg), UVM_LOW) 
    endfunction: pre_randomize

    function void post_randomize();
        string str_cfg;
        string str_out_cfg;
        str_cfg = {str_cfg, $sformatf("Randomize sequence counter = %2d", seq_count)};
        str_out_cfg = $sformatf("%s\n", str_cfg);
        `uvm_info ("POST_RANDOMIZE", $sformatf("SEQUENCE POST CONFIG: %s", str_out_cfg), UVM_LOW)
    endfunction: post_randomize

endclass: axi_lite_master_sequence