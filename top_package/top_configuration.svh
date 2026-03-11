class top_configuration extends uvm_object;

    `uvm_object_utils(top_configuration)

    rand axi_lite_agent_config axi_cfg[string];
    rand microwire_agent_config mic_cfg[string];

    uvm_active_passive_enum is_active = UVM_ACTIVE;
    bit enable_check = 1'b0;
    bit enable_coverage = 1'b0;
    bit has_scoreboard = 1'b1;

    rand int seq_min;
    rand int seq_max;

    constraint seq_cnstr {
        seq_min > 0; 
        seq_max < 10000;
        seq_max > seq_min;
    }

    function new(string name = "top_configuration");
        super.new(name);
        create_agent_config();
    endfunction: new

    virtual function void create_agent_config();
        axi_cfg["master"] = axi_lite_agent_config::type_id::create("axi_cfg");
        axi_cfg["master"].is_active = UVM_ACTIVE;
        axi_cfg["master"].coverage_enable = 1'b0;
        axi_cfg["master"].checks_enable = 1'b0;

        mic_cfg["slave"] = microwire_agent_config::type_id::create("mic_cfg");
        mic_cfg["slave"].is_active = UVM_PASSIVE;
        mic_cfg["slave"].coverage_enable = 1'b0;
        mic_cfg["slave"].checks_enable = 1'b0;
    endfunction: create_agent_config

endclass: top_configuration