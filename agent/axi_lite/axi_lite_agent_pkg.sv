package axi_lite_agent_pkg;
    
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    import axi_lite_inf_pkg::*;

    `include "axi_lite_agent_config.svh"
    `include "axi_lite_item.svh"
    `include "axi_lite_driver.svh"
    `include "axi_lite_monitor.svh"
    typedef uvm_sequencer #(axi_lite_item) sequencer_axi_lite;
    `include "axi_lite_agent.svh"

endpackage: axi_lite_agent_pkg