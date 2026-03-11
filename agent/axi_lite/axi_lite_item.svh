class axi_lite_item extends uvm_sequence_item;
    
    `uvm_object_utils(axi_lite_item)

    static axi_lite_agent_config axi_lite_config;
    
    // Read Address
    rand logic [3 : 0] item_araddr;
    rand logic [2 : 0] item_arprot;
    rand logic         item_arvalid;
    rand logic         item_arready;
    // Read Data
    rand logic [31 : 0] item_rdata;
    rand logic [1 : 0]  item_rresp;
    rand logic          item_rvalid;
    rand logic          item_rready;
    // Write Address
    rand logic [3 : 0] item_awaddr;
    rand logic [2 : 0] item_awprot;
    rand logic         item_awvalid;
    rand logic         item_awready;
    // Write Data
    rand logic [31 : 0] item_wdata;
    rand logic [3 : 0]  item_wstrb;
    rand logic          item_wvalid;
    rand logic          item_wready;
    // Write Response
    rand logic [1 : 0] item_bresp;
    rand logic         item_bvalid;
    rand logic         item_bready;
    
    function new(string name = "axi_lite_item");
        super.new(name);
    endfunction: new

    function string convert2string();
        string s;
        s = $sformatf("axi_lite_wdata = 0x%2h\n", item_wdata);
        return s;
    endfunction: convert2string

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        axi_lite_item rhs_item;
        bit status = 1;
        if (!$cast(rhs_item, rhs)) begin
            `uvm_fatal(get_full_name(), "cast failed")
            return 0;
        end
        status &= comparer.compare_field("item_wdata", 
                                         this.item_wdata, 
                                         rhs_item.item_wdata, 
                                         $bits(this.item_wdata));
        status &= super.do_compare(rhs, comparer);
        return status;
    endfunction: do_compare

endclass: axi_lite_item