class microwire_item extends uvm_sequence_item;
    
    `uvm_object_utils(microwire_item)

    microwire_agent_config microwire_config;

    logic item_microwire_data;
    logic item_microwire_clk;
    logic item_microwire_le;

    bit bit_array [32];
    bit [31 : 0] expected_data;
    
    function new(string name = "microwire_item");
        super.new(name);
    endfunction: new

    function string convert2string();
        string s;
        s = $sformatf("microwire_data = 0x%2h\n", expected_data);
        return s;
    endfunction: convert2string

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        microwire_item rhs_item;
        bit status = 1;
        if (!$cast(rhs_item, rhs)) begin
            `uvm_fatal(get_full_name(), "cast failed")
            return 0;
        end
        status &= comparer.compare_field("item_wdata", 
                                         this.expected_data, 
                                         rhs_item.expected_data, 
                                         $bits(this.expected_data));
        status &= super.do_compare(rhs, comparer);
        return status;
    endfunction: do_compare

endclass: microwire_item