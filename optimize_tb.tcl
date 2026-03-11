puts {
	*** OPTIMIZATION SCRIPT ***
}

set tb_opt_string "vopt +acc=npr -L ${lib_name} \\\n"
append tb_opt_string "-L unisims_ver  \\\n"
append tb_opt_string "-L unimacro_ver  \\\n"
append tb_opt_string "-L secureip  \\\n"

append tb_opt_string "-work ${lib_name} ${lib_name}.axi_microwire_tb ${lib_name}.glbl -o tb_top_opt"

eval exec $tb_opt_string