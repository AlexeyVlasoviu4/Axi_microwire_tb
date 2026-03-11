class inf_axi_lite_abstract extends uvm_object;

    `uvm_object_utils(inf_axi_lite_abstract)

    function new(string name = "inf_axi_lite_abstract");
        super.new(name);
    endfunction: new

    virtual task wait_reset_done();
        // wait aresetn positive or negative edge
    endtask: wait_reset_done

    virtual task wait_clk();
        // wait clock positive or negative edge
    endtask: wait_clk

    virtual task reset_signals();
        // axi-lite reset all signals
    endtask: reset_signals

    virtual task wait_low_rdata();
        // wait rdata signal is zero for write/read data
    endtask: wait_low_rdata

    virtual task read_address(
        input logic [31 : 0] address,
        input logic [2 : 0]  protection
    );
    endtask: read_address

    virtual task write_addr_data(
        input logic [31 : 0] address,
        input logic [2 : 0]  protection,
        input logic [31 : 0] data,
        input logic [3 : 0]  strobe
    );
    endtask: write_addr_data

    virtual task set_rready(input bit value);
        // rready set low or high value signal
    endtask: set_rready

    virtual task set_bready(input bit value);
        // response set low or high signal
    endtask: set_bready

    virtual task repeat_clk(input int cycles);
        // aclk signal repeat value
    endtask: repeat_clk

    virtual function bit set_handshake();
        return 1'b0;
    endfunction: set_handshake
    
    virtual function logic [63 : 0] get_wdata();
        return 64'h0;
    endfunction: get_wdata

    virtual function logic [63 : 0] get_awaddr();
        return 64'h0;
    endfunction: get_awaddr

endclass: inf_axi_lite_abstract