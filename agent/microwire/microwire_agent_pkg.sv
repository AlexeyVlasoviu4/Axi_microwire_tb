package microwire_agent_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "microwire_agent_config.svh"
    `include "microwire_item.svh"
    `include "microwire_monitor.svh"
    typedef uvm_sequencer #(microwire_item) sequencer_microwire;
    `include "microwire_agent.svh"

endpackage: microwire_agent_pkg