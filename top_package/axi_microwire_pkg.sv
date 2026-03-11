package axi_microwire_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import axi_lite_inf_pkg::*;
    import axi_lite_agent_pkg::*;
    import microwire_agent_pkg::*;

    `include "top_configuration.svh"
    `include "axi_microwire_predictor.svh"
    `include "axi_microwire_scoreboard.svh"
    `include "axi_lite_master_sequence.svh"
    `include "axi_microwire_env.svh"
    `include "axi_microwire_test.svh"

endpackage: axi_microwire_pkg