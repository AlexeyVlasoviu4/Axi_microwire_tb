class microwire_monitor extends uvm_monitor;

    `uvm_component_utils(microwire_monitor)
    
    virtual inf_axi_microwire vif;

    microwire_item monitor_item;
    uvm_analysis_port #(microwire_item) microwire_ap;
    microwire_agent_config monitor_config;
    bit checks_enable = 1'b0;
    bit coverage_enable = 1'b0;
    
    function new(string name = "microwire_monitor", uvm_component parent = null);
        super.new(name, parent);
        // collect_axis_stream = new();
        // collect_axis_stream.set_inst_name({get_full_name(), ".collect_axis_stream"});
    endfunction: new
        
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        microwire_ap = new("microwire_ap", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_signals();
        @(posedge vif.aresetn);
        fork
            collect_transactions();
            // perform_transfer_coverage();
        join
    endtask: run_phase
    
    virtual task collect_transactions();
        forever begin
            monitor_item = microwire_item::type_id::create("monitor_item", this);
            foreach (monitor_item.bit_array[i]) begin
                @(posedge vif.microwire_clk);
                monitor_item.bit_array[i] = vif.microwire_data;
            end
            @(posedge vif.microwire_le);
            // `uvm_info("SLAVE MONITOR", $sformatf("Written data = %s", monitor_item.convert2string()), UVM_LOW)
            microwire_ap.write(monitor_item);
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
            @(posedge vif.aclk);
            //if (coverage_enable) begin
                // collect_axis_stream.sample();
            //end
        end
    endtask: perform_transfer_coverage

    virtual task reset_signals();
        vif.microwire_data <= 1'b0;
        vif.microwire_clk  <= 1'b0;
        vif.microwire_le   <= '0;
    endtask: reset_signals

    /*virtual function void final_phase(uvm_phase phase);
        super.final_phase(phase);
        $fclose(file_handle_1);
    endfunction: final_phase*/
    
endclass: microwire_monitor