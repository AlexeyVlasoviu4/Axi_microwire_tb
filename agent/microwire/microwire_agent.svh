class microwire_agent extends uvm_agent;
    
    `uvm_component_utils(microwire_agent)
    
    microwire_agent_config slave_agent_config;
    
    microwire_monitor agent_monitor;
    
    uvm_analysis_port #(microwire_item) microwire_agent_ap;
    
    function new( string name = "microwire_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        microwire_agent_ap = new("microwire_agent_ap", this);
        agent_monitor = microwire_monitor::type_id::create("agent_monitor", this);
        if (slave_agent_config == null) begin
            `uvm_fatal("CFG_ERROR", "agent_config is not set!")
        end
        if (slave_agent_config.is_active == UVM_ACTIVE) begin
            // 
        end
    endfunction: build_phase
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (slave_agent_config == null) begin
            `uvm_fatal("CFG_ERROR", "agent_config is not set!")
        end
        agent_monitor.vif = slave_agent_config.vif;
        agent_monitor.microwire_ap.connect(microwire_agent_ap);
        agent_monitor.monitor_config = slave_agent_config;
        if (slave_agent_config.is_active == UVM_ACTIVE) begin
            // 
        end
    endfunction: connect_phase
    
endclass: microwire_agent