class inf_axi_lite_actual #(
    int C_S00_AXI_DATA_WIDTH = 32,
    int C_S00_AXI_ADDR_WIDTH = 4
) extends inf_axi_lite_abstract;

    `uvm_object_param_utils(inf_axi_lite_actual #(
        C_S00_AXI_DATA_WIDTH,
        C_S00_AXI_ADDR_WIDTH
    ))

    virtual inf_axi_lite #(
        C_S00_AXI_DATA_WIDTH, 
        C_S00_AXI_ADDR_WIDTH
    ) vif;

    function new(string name = "inf_axi_lite_actual");
        super.new(name);
    endfunction: new

    virtual task wait_reset_done();
        @(posedge vif.aresetn);
    endtask: wait_reset_done

    virtual task wait_clk();
        @(posedge vif.aclk);
    endtask: wait_clk

    virtual function bit set_handshake();
        return (vif.wvalid && vif.wready);
    endfunction: set_handshake

    virtual task wait_low_rdata();
        wait(!vif.rdata);
    endtask: wait_low_rdata

    virtual task repeat_clk(input int cycles);
        repeat(cycles) @(posedge vif.aclk);
    endtask: repeat_clk

    virtual function logic [63 : 0] get_wdata();
        logic [63 : 0] data = '0;
        data [C_S00_AXI_DATA_WIDTH - 1 : 0] = vif.wdata;
        return data;
    endfunction: get_wdata

    virtual function logic [63 : 0] get_awaddr();
        logic [63 : 0] addr = '0;
        addr [C_S00_AXI_ADDR_WIDTH - 1 : 0] = vif.awaddr;
        return addr;
    endfunction: get_awaddr

    virtual task read_address(
        input logic [31 : 0] address,
        input logic [2 : 0]  protection
    );
        vif.arvalid <= 1'b1;
        vif.araddr  <= address [C_S00_AXI_ADDR_WIDTH - 1 : 0];
        vif.arprot  <= protection;
        do begin
            @(posedge vif.aclk);
        end
        while (!vif.arready);
        vif.arvalid <= 1'b0;
    endtask: read_address

    virtual task write_addr_data(
        input logic [63 : 0] address,
        input logic [2 : 0]  protection,
        input logic [63 : 0] data,
        input logic [7 : 0]  strobe
    );
        vif.awvalid <= 1'b1;
        vif.awaddr  <= address [C_S00_AXI_ADDR_WIDTH - 1 : 0];
        vif.awprot  <= protection;
        do begin
            @(posedge vif.aclk);
        end
        while (!vif.awready);
        vif.awvalid <= 1'b0;

        vif.wvalid <= 1'b1;
        vif.wdata  <= data [C_S00_AXI_DATA_WIDTH - 1 : 0];
        vif.wstrb  <= strobe [(C_S00_AXI_DATA_WIDTH/8) - 1 : 0];
        do begin
            @(posedge vif.aclk);
        end
        while (!vif.wready);
        vif.wvalid <= 1'b0;
    endtask: write_addr_data

    virtual task set_rready(input bit value);
        vif.rready <= value;
    endtask: set_rready

    virtual task set_bready(input bit value);
        vif.bready <= value;
    endtask: set_bready

    virtual task reset_signals();
        vif.arvalid <= 1'b0;
        vif.arready <= 1'b0;
        vif.araddr  <= '0;
        vif.arprot  <= '0;

        vif.rvalid <= 1'b0;
        vif.rready <= 1'b0;
        vif.rdata  <= '0;
        vif.rresp  <= '0;

        vif.awvalid <= 1'b0;
        vif.awready <= 1'b0;
        vif.awaddr  <= '0;
        vif.awprot  <= 3'b000;

        vif.wready <= 1'b0;
        vif.wvalid <= 1'b0;
        vif.wdata  <= '0;
        vif.wstrb  <= 4'b0000;

        vif.bready <= 1'b0;
        vif.bvalid <= 1'b0;
        vif.bresp  <= 2'b00;
    endtask: reset_signals

endclass: inf_axi_lite_actual