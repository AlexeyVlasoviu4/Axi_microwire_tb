class axi_lite_agent extends uvm_agent;
    
    `uvm_component_utils(axi_lite_agent)
    
    axi_lite_agent_config master_agent_config;
    
    sequencer_axi_lite axi_lite_seqr;
    axi_lite_driver master_agent_driver;
    axi_lite_monitor agent_monitor;
    
    uvm_analysis_port #(axi_lite_item) axi_lite_agent_ap;
    
    function new(string name = "axi_lite_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_lite_agent_ap = new("axi_lite_agent_ap", this);
        agent_monitor = axi_lite_monitor::type_id::create("agent_monitor", this);
        if (master_agent_config == null) begin
            `uvm_fatal("CFG_ERROR", "agent_config is not set!")
        end
        if (master_agent_config.is_active == UVM_ACTIVE) begin
            master_agent_driver = axi_lite_driver::type_id::create("master_agent_driver", this);
            axi_lite_seqr = sequencer_axi_lite::type_id::create("axi_lite_seqr", this);
        end
    endfunction: build_phase
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (master_agent_config == null) begin
            `uvm_fatal("CFG_ERROR", "agent_config is not set!")
        end
        agent_monitor.vif_access = master_agent_config.vif_accessor;
        agent_monitor.axi_lite_ap.connect(axi_lite_agent_ap);
        agent_monitor.monitor_config = master_agent_config;
        if (master_agent_config.is_active == UVM_ACTIVE) begin
            master_agent_driver.seq_item_port.connect(axi_lite_seqr.seq_item_export);
            master_agent_driver.vif_access = master_agent_config.vif_accessor;
            master_agent_driver.driver_item.axi_lite_config = master_agent_config;
            master_agent_driver.driver_config = master_agent_config;
        end
    endfunction: connect_phase
    
endclass: axi_lite_agent