puts {
	*** COMPILATION SCRIPT ***
}

if {![info exists lib_name]} {
	set lib_name work
}

quietly set path_dut           [file join [pwd]]

if [catch [vlib ${lib_name}]] {
    puts "library exists"
}

set incl_dir_list "
	[file join $::env(MODEL_TECH) .. uvm-1.1d .. verilog_src uvm-1.1d src]
	[file dirname ${path_dut}]
	[file join ${path_dut} srcs incl]
"

quietly set glbl_loc [file join .. data verilog src glbl.v]
quietly set dirlst [split $::env(PATH) ";"]
quietly set glbl_found 0
foreach dir $dirlst {
	quietly set tstfile [file join $dir $glbl_loc]
	if {[file exists $tstfile]} {
		set glbl_file ${tstfile}
		quietly set glbl_found 1
	} 
}

if {![info exists TOP_DEFINE]} {
	set TOP_DEFINE ""
}

set tb_compile_string "vlog -sv -incr -mfcu -work ${lib_name} ${TOP_DEFINE} ${glbl_file} \\
    [file join ${path_dut} interface inf_axi_lite.sv] \\
	[file join ${path_dut} interface inf_axi_microwire.sv]\\
	[file join ${path_dut} hdl microwire_driver.sv] \\
	[file join ${path_dut} hdl AXI_MICROWIRE_slave_lite_v1_0_S00_AXI.v] \\
    [file join ${path_dut} hdl AXI_MICROWIRE.v] \\
    [file join ${path_dut} agent microwire microwire_agent_pkg.sv] \\
    [file join ${path_dut} agent axi_lite axi_lite_agent_pkg.sv] \\
    [file join ${path_dut} top_package axi_microwire_pkg.sv] \\
    [file join ${path_dut} axi_microwire_tb.sv]"

eval exec $tb_compile_string