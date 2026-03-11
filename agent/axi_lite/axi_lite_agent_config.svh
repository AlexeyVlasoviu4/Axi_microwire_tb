class axi_lite_agent_config extends uvm_object;

    `uvm_object_utils(axi_lite_agent_config)
    
    inf_axi_lite_abstract vif_accessor;
    
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    bit coverage_enable;
    bit checks_enable;
    
    bit [31 : 0] addr_csr      = 32'h0;
    bit [31 : 0] data_csr      = 32'h1;
    bit [31 : 0] addr_data_out = 32'h4;
    bit [2 : 0] prot_config    = 3'b000;
    bit [3 : 0] strb_config    = 4'hF;

    typedef enum {WAIT_FIRST, SKIP_SECOND} state_e;
    state_e state = WAIT_FIRST;

    rand int delay_rready_min = 10;
    rand int delay_rready_max = 10;
    int min_rready            = 1;
    int max_rready            = 100;

    rand int delay_bready_min = 3;
    rand int delay_bready_max = 3;
    int min_bready            = 2;
    int max_bready            = 100;

    constraint cnstr_delay_rready {
        delay_rready_min inside {[min_rready : max_rready]};
        delay_rready_max inside {[min_rready : max_rready]};
        delay_rready_max > delay_rready_min;
    };
    
    constraint cnstr_delay_bready {
        delay_bready_min inside {[min_bready : max_bready]};
        delay_bready_max inside {[min_bready : max_bready]};
        delay_bready_max > delay_bready_min;
    };

    function new(string name = "axi_lite_agent_config");
        super.new(name);
    endfunction: new

    function void pre_randomize();
        string str_cfg;
        string str_out_cfg;
        str_cfg = {str_cfg, $sformatf(
            "Pre randomize rready delay min = %2d max = %2d", delay_rready_min, delay_rready_max
        )};
        str_cfg = {str_cfg, $sformatf(
            " Post randomize bready delay min = %2d, max = %2d\n", delay_bready_min, delay_bready_max
        )};
        str_out_cfg = $sformatf("%s", str_cfg);
        `uvm_info ("PRE_RANDOMIZE", $sformatf("AXI-LITE AGENT CONFIG: %s", str_out_cfg), UVM_LOW)
    endfunction: pre_randomize
    
    function void post_randomize();
        string str_cfg;
        string str_out_cfg;
        str_cfg = {str_cfg, $sformatf(
            "Randomize rready delay min = %2d max = %2d", delay_rready_min, delay_rready_max
        )};
        str_cfg = {str_cfg, $sformatf(
            " Randomize bready delay min = %2d, max = %2d\n", delay_bready_min, delay_bready_max
        )};
        str_out_cfg = $sformatf("%s", str_cfg);
        `uvm_info ("POST_RANDOMIZE", $sformatf("AXI-LITE AGENT CONFIG: %s", str_out_cfg), UVM_LOW)
    endfunction: post_randomize

endclass: axi_lite_agent_config