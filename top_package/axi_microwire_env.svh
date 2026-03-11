class axi_microwire_env extends uvm_env;

    `uvm_component_utils(axi_microwire_env)

    top_configuration top_config_env;
    axi_lite_agent_config master_config_env;
    microwire_agent_config slave_config_env;

    axi_lite_agent master_agent_env;
    microwire_agent slave_agent_env;

    axi_microwire_scoreboard scoreboard_env;
    axi_microwire_predictor predictor_env;
    
    function new(string name = "axi_microwire_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        if (!uvm_config_db #(top_configuration)::get(
            this,
            "",
            "config",
            top_config_env
        )) begin
            `uvm_fatal({get_full_name(), "CFG_ERROR"}, "Configuration not found")
        end

        master_agent_env = axi_lite_agent::type_id::create("master_agent_env", this);
        slave_agent_env  = microwire_agent::type_id::create("slave_agent_env", this);
        
        master_config_env = top_config_env.axi_cfg["master"];
        slave_config_env  = top_config_env.mic_cfg["slave"];

        master_agent_env.master_agent_config = top_config_env.axi_cfg["master"];
        slave_agent_env.slave_agent_config   = top_config_env.mic_cfg["slave"];

        if (top_config_env.has_scoreboard) begin
            scoreboard_env = axi_microwire_scoreboard::type_id::create("scoreboard_env", this);
            predictor_env = axi_microwire_predictor::type_id::create("predictor_env", this);
        end
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (top_config_env.has_scoreboard) begin
            master_agent_env.axi_lite_agent_ap.connect(scoreboard_env.axis_mic_received);
            predictor_env.microwire_result_out.connect(scoreboard_env.axis_mic_exepcted);
            slave_agent_env.microwire_agent_ap.connect(predictor_env.microwire_result_in.analysis_export);
        end
    endfunction: connect_phase

endclass: axi_microwire_env