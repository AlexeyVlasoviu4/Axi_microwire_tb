class axi_lite_driver extends uvm_driver #(axi_lite_item);
    
    `uvm_component_utils(axi_lite_driver)
    
    axi_lite_item driver_item;
    axi_lite_agent_config driver_config;
    inf_axi_lite_abstract vif_access;
    
    function new (string name = "axi_lite_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif_access.reset_signals();
        vif_access.wait_reset_done();
        fork
            forever begin
                seq_item_port.get_next_item(driver_item);
                drive_item(
                    .item(driver_item), 
                    .cfg(driver_config)
                );
                seq_item_port.item_done();
            end
            rready_gen(.cfg(driver_config));
            response_gen(.cfg(driver_config));
        join
    endtask: run_phase
    
    virtual task drive_item(
        input axi_lite_item item,
        input axi_lite_agent_config cfg
    );
        vif_access.write_addr_data(
            .address(cfg.addr_data_out),
            .protection(cfg.prot_config),
            .data(item.item_wdata),
            .strobe(cfg.strb_config)
        );
        vif_access.write_addr_data(
            .address(cfg.addr_csr),
            .protection(cfg.prot_config),
            .data(cfg.data_csr),
            .strobe(cfg.strb_config)
        );
        vif_access.read_address(
            .address(cfg.addr_csr),
            .protection(cfg.prot_config)
        );
        vif_access.wait_low_rdata();
    endtask: drive_item

    virtual task rready_gen(input axi_lite_agent_config cfg);
        int delay = 0;
        forever begin
            if (!std::randomize(delay) with {
                delay inside {[cfg.delay_rready_min : cfg.delay_rready_max]};
            })  begin
                $error("Error std::randomize");
            end
            vif_access.set_rready(1'b0);
            vif_access.repeat_clk(delay * 2);
            vif_access.set_rready(1'b1);
            vif_access.repeat_clk(delay);
        end
    endtask: rready_gen

    virtual task response_gen(input axi_lite_agent_config cfg);
        int delay = 0;
        forever begin
            if (!std::randomize(delay) with {
                delay inside {[cfg.delay_bready_min : cfg.delay_bready_max]};
            })  begin
                $error("Error std::randomize");
            end
            vif_access.set_bready(1'b0);
            vif_access.repeat_clk(delay * 3);
            vif_access.set_bready(1'b1);
            vif_access.repeat_clk(delay);
        end
    endtask: response_gen
        
endclass: axi_lite_driver