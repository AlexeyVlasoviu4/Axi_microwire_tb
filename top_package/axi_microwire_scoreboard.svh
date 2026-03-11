class axi_microwire_scoreboard extends uvm_component;

    `uvm_component_utils(axi_microwire_scoreboard)

    uvm_analysis_export #(axi_lite_item) axis_mic_received;
    uvm_analysis_export #(microwire_item) axis_mic_exepcted;

    uvm_tlm_analysis_fifo #(axi_lite_item) received_fifo;
    uvm_tlm_analysis_fifo #(microwire_item) exepcted_fifo;

    int all_tests;
    int match_result;
    
    function new(string name = "axis_scrb", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_mic_received = new("axis_mic_received", this);
        axis_mic_exepcted = new("axis_mic_exepcted", this);
        received_fifo     = new("received_fifo", this);
        exepcted_fifo     = new("exepcted_fifo", this);
    endfunction: build_phase
    
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        axis_mic_received.connect(received_fifo.analysis_export);
        axis_mic_exepcted.connect(exepcted_fifo.analysis_export);
    endfunction: connect_phase
    
    virtual task run_phase(uvm_phase phase);
        axi_lite_item predictor_item;
        microwire_item actual_item;
        forever begin
            fork
                received_fifo.get(predictor_item);
                exepcted_fifo.get(actual_item);
            join
            // `uvm_info("SCOREBOARD", $sformatf("Actual: %s", actual_item.convert2string()), UVM_LOW)
            // `uvm_info("SCOREBOARD", $sformatf("Pred: %s", predictor_item.convert2string()), UVM_LOW)
            all_tests++;
            if (predictor_item.item_wdata != actual_item.expected_data) begin
                `uvm_error("SCOREBOARD", $sformatf("Mismatch! Pred: %s Actual: %s\n",
                    actual_item.convert2string(), predictor_item.convert2string()
                ))
            end else begin
                match_result++;
            end
        end
    endtask: run_phase
    
    virtual function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        my_summarize_test_results();
    endfunction: extract_phase

    virtual function void my_summarize_test_results();
        real total;
        total = (match_result * 1.0 / all_tests) * 100;
        `uvm_info("RESULT", $sformatf(
            "TOTAL TESTS = %2d, TOTAL MATCHES = %2d Statistic = %0.2f%%", 
            all_tests, 
            match_result, 
            total
        ), UVM_MEDIUM)
    endfunction: my_summarize_test_results

endclass: axi_microwire_scoreboard