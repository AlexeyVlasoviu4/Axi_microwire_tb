class axi_microwire_predictor extends uvm_component;

    `uvm_component_utils(axi_microwire_predictor)

    uvm_tlm_analysis_fifo #(microwire_item) microwire_result_in;
    uvm_analysis_port #(microwire_item) microwire_result_out;

    function new(string name = "axi_microwire_predictor", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        microwire_result_in = new("microwire_result_in", this);
        microwire_result_out = new("microwire_result_out", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        microwire_item transaction_input;
        microwire_item transaction_output;
        forever begin
            microwire_result_in.get(transaction_input);
            transaction_output = microwire_item::type_id::create("transaction_output");
            foreach (transaction_input.bit_array[i]) begin
                transaction_output.expected_data [31 - i] = transaction_input.bit_array[i];
            end
            microwire_result_out.write(transaction_output);
            // `uvm_info("PREDICTOR", $sformatf("Execepted data: = %s", transaction_output.convert2string()), UVM_LOW)
        end
    endtask: run_phase

endclass: axi_microwire_predictor