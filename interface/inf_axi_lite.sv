interface  inf_axi_lite #(
    int C_S00_AXI_DATA_WIDTH = 32,
    int C_S00_AXI_ADDR_WIDTH = 4
) (
    input logic aclk,
    input logic aresetn
);  
    // Read Address
    logic [C_S00_AXI_ADDR_WIDTH - 1 : 0] araddr;
    logic [2 : 0] arprot;
    logic arvalid;
    logic arready;
    // Read Data
    logic [C_S00_AXI_DATA_WIDTH - 1 : 0] rdata;
    logic [1 : 0] rresp;
    logic rvalid;
    logic rready;
    // Write Address
    logic [C_S00_AXI_ADDR_WIDTH - 1 : 0] awaddr;
    logic [2 : 0] awprot;
    logic awvalid;
    logic awready;
    // Write Data
    logic [C_S00_AXI_DATA_WIDTH - 1 : 0] wdata;
    logic [(C_S00_AXI_DATA_WIDTH / 8) - 1 : 0] wstrb;
    logic wvalid;
    logic wready;
    // Write Response
    logic [1 : 0] bresp;
    logic bvalid;
    logic bready;

endinterface: inf_axi_lite