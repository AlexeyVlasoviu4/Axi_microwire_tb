quit -sim

puts {
	*** VIP AXIS SELF TEST MAIN SCRIPT ***
}

source [file join [pwd] compile_tb.tcl]
source [file join [pwd] optimize_tb.tcl]

vsim -voptargs=+acc work.tb_top_opt +UVM_TESTNAME=axi_microwire_test

do wave_mic_uvm.do

run -all
