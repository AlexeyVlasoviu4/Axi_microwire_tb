class microwire_agent_config extends uvm_object;

    `uvm_object_utils(microwire_agent_config)
    
    virtual inf_axi_microwire vif;
    
    uvm_active_passive_enum is_active = UVM_PASSIVE;
    bit coverage_enable;
    bit checks_enable;

    function new(string name = "microwire_agent_config");
        super.new(name);
    endfunction: new

endclass: microwire_agent_config