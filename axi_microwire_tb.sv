`timescale 1ns / 1ps

`define DEF_PERIOD_CLK 10.0

module axi_microwire_tb # ();

import uvm_pkg::*;
`include "uvm_macros.svh"
import axi_lite_inf_pkg::*;
import axi_microwire_pkg::*;

bit aclk;
bit aresetn;

inf_axi_lite #(
    .C_S00_AXI_DATA_WIDTH(32), 
    .C_S00_AXI_ADDR_WIDTH(4)
) master_axi_lite_vif (aclk, aresetn);

inf_axi_lite_actual #(
    .C_S00_AXI_DATA_WIDTH(32),
    .C_S00_AXI_ADDR_WIDTH(4)
) inf_wrapper;

inf_axi_microwire slave_microwire_vif (aclk, aresetn);

top_configuration top_config;

axi_microwire # (
    .CLK_DIV(10),
    .C_S00_AXI_ADDR_WIDTH(4),
    .C_S00_AXI_DATA_WIDTH(32)
) DUT (
    .aclk(aclk),
    .aresetn(aresetn),

    // AXI-LITE
    // Read Address
    .s00_axi_araddr(master_axi_lite_vif.araddr),
    .s00_axi_arprot(master_axi_lite_vif.arprot),
    .s00_axi_arvalid(master_axi_lite_vif.arvalid),
    .s00_axi_arready(master_axi_lite_vif.arready),
    // Read Data
    .s00_axi_rdata(master_axi_lite_vif.rdata),
    .s00_axi_rresp(master_axi_lite_vif.rresp),
	.s00_axi_rvalid(master_axi_lite_vif.rvalid),
	.s00_axi_rready(master_axi_lite_vif.rready),
    // Write Address
	.s00_axi_awaddr(master_axi_lite_vif.awaddr),
	.s00_axi_awprot(master_axi_lite_vif.awprot),
	.s00_axi_awvalid(master_axi_lite_vif.awvalid),
	.s00_axi_awready(master_axi_lite_vif.awready),
    // Write Data
	.s00_axi_wdata(master_axi_lite_vif.wdata),
	.s00_axi_wstrb(master_axi_lite_vif.wstrb),
	.s00_axi_wvalid(master_axi_lite_vif.wvalid),
	.s00_axi_wready(master_axi_lite_vif.wready),
    // Write Response
	.s00_axi_bresp(master_axi_lite_vif.bresp),
	.s00_axi_bvalid(master_axi_lite_vif.bvalid),
	.s00_axi_bready(master_axi_lite_vif.bready),

    // AXI_MIRCOWIRE
    .DATA(slave_microwire_vif.microwire_data),
    .CLK(slave_microwire_vif.microwire_clk),
    .LE(slave_microwire_vif.microwire_le)
);

// Clocking
initial begin
    aclk <= 0;
    forever begin
        #((`DEF_PERIOD_CLK / 2) * 1.0ns);
        aclk = ~aclk;
    end
end

// Reset
initial begin
    aresetn <= 1'b0;
    repeat(20) @(posedge aclk);
    aresetn <= 1'b1;
end

// Time format
initial begin
    $timeformat(-6, 3, "us", 1); // $timeformat(-6, -4, "ns", 1);
end

initial begin
    top_config = top_configuration::type_id::create("top_config");
    inf_wrapper = new("inf_wrapper");
    inf_wrapper.vif = master_axi_lite_vif;

    if (!top_config.randomize()) begin
        `uvm_fatal("TOP CFG", "Failed to randomize top-level configuartion object");
    end

    top_config.axi_cfg["master"].vif_accessor = inf_wrapper;
    top_config.mic_cfg["slave"].vif = slave_microwire_vif;
    
    top_config.is_active = UVM_ACTIVE;
    top_config.enable_check = 1'b0;
    top_config.enable_coverage = 1'b0;
    top_config.has_scoreboard = 1'b1;

    uvm_config_db #(top_configuration)::set(
        null,
        "*",
        "config",
        top_config
    );
    run_test("");
end

endmodule: axi_microwire_tb