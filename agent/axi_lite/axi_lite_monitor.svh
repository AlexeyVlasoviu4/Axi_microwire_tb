class axi_lite_monitor extends uvm_monitor;

    `uvm_component_utils(axi_lite_monitor)
    
    inf_axi_lite_abstract vif_access;

    axi_lite_item monitor_item;
    uvm_analysis_port #(axi_lite_item) axi_lite_ap;
    axi_lite_agent_config monitor_config;
    bit checks_enable = 1'b0;
    bit coverage_enable = 1'b0;
    
    function new(string name = "axi_lite_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
        
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_lite_ap = new("axi_lite_ap", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif_access.wait_reset_done();
        fork
            collect_transactions();
            // perform_transfer_coverage();
        join
    endtask: run_phase
    
    virtual task collect_transactions();
        forever begin
            monitor_item = axi_lite_item::type_id::create("monitor_item", this);
            vif_access.wait_clk();
            if (vif_access.set_handshake()) begin
                case (monitor_config.state)
                    monitor_config.WAIT_FIRST: begin
                        monitor_item.item_wdata = vif_access.get_wdata();
                        axi_lite_ap.write(monitor_item);
                        // `uvm_info("MASTER MONITOR",
                        //         $sformatf("Written data: wdata = %s", 
                        //             monitor_item.convert2string()), 
                        //             UVM_LOW)
                        monitor_config.state = monitor_config.SKIP_SECOND;
                    end
                    monitor_config.SKIP_SECOND: begin
                        // `uvm_info(get_type_name(), 
                        //       "Skipping second handshake", 
                        //       UVM_LOW)
                        monitor_config.state = monitor_config.WAIT_FIRST;
                    end
                endcase
            end
            if (checks_enable) begin
                checks_transactions();
            end
        end
    endtask: collect_transactions
    
    virtual function void checks_transactions();
        //check_transfer_void();
        //check_transfer_delay();
    endfunction: checks_transactions

    virtual task perform_transfer_coverage();
        forever begin
            // @(posedge vif.aclk);
            //if (coverage_enable) begin
                // collect_axis_stream.sample();
            //end
        end
    endtask: perform_transfer_coverage

    virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
    endfunction: final_phase
    
endclass: axi_lite_monitor