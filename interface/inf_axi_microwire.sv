interface inf_axi_microwire #() (
    input logic aclk,
    input logic aresetn
);

    logic microwire_data;
    logic microwire_clk;
    logic microwire_le;

endinterface: inf_axi_microwire