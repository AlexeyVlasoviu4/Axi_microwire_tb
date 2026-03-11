class axi_microwire_test extends uvm_test;

    `uvm_component_utils(axi_microwire_test)

    axi_microwire_env axi_microwire_env_test;
    axi_lite_master_sequence gen_master_seq;
    top_configuration top_config_test;

    function new(string name = "axi_microwire_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_microwire_env_test = axi_microwire_env::type_id::create("axi_microwire_env_test", this);
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        if (!uvm_config_db #(top_configuration)::get(
            this,
            "",
            "config",
            top_config_test
        )) begin
            `uvm_fatal({get_full_name(), "CFG_ERROR"}, "Configuration not found")
        end
        
        gen_master_seq = axi_lite_master_sequence::type_id::create("gen_master_seq");

        gen_master_seq.seq_count_min = top_config_test.seq_min;
        gen_master_seq.seq_count_max = top_config_test.seq_max;

        if (!gen_master_seq.randomize()) begin
            `uvm_fatal({get_full_name(), "FIRST SEQ"}, "Randomize failed")
        end
        gen_master_seq.start(axi_microwire_env_test.master_agent_env.axi_lite_seqr);
        phase.drop_objection(this);
    endtask: run_phase

endclass: axi_microwire_test