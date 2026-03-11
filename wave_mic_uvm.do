onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axi_microwire_tb/aclk
add wave -noupdate /axi_microwire_tb/aresetn
add wave -noupdate -expand -group AXI-Lite_READ_ADDRESS /axi_microwire_tb/master_axi_lite_vif/araddr
add wave -noupdate -expand -group AXI-Lite_READ_ADDRESS /axi_microwire_tb/master_axi_lite_vif/arprot
add wave -noupdate -expand -group AXI-Lite_READ_ADDRESS /axi_microwire_tb/master_axi_lite_vif/arvalid
add wave -noupdate -expand -group AXI-Lite_READ_ADDRESS /axi_microwire_tb/master_axi_lite_vif/arready
add wave -noupdate -expand -group AXI-Lite_READ_DATA /axi_microwire_tb/master_axi_lite_vif/rdata
add wave -noupdate -expand -group AXI-Lite_READ_DATA /axi_microwire_tb/master_axi_lite_vif/rresp
add wave -noupdate -expand -group AXI-Lite_READ_DATA /axi_microwire_tb/master_axi_lite_vif/rvalid
add wave -noupdate -expand -group AXI-Lite_READ_DATA /axi_microwire_tb/master_axi_lite_vif/rready
add wave -noupdate -expand -group AXI-Lite_WRITE_ADDRESS /axi_microwire_tb/master_axi_lite_vif/awaddr
add wave -noupdate -expand -group AXI-Lite_WRITE_ADDRESS /axi_microwire_tb/master_axi_lite_vif/awprot
add wave -noupdate -expand -group AXI-Lite_WRITE_ADDRESS /axi_microwire_tb/master_axi_lite_vif/awvalid
add wave -noupdate -expand -group AXI-Lite_WRITE_ADDRESS /axi_microwire_tb/master_axi_lite_vif/awready
add wave -noupdate -expand -group AXI-Lite_WRITE_DATA /axi_microwire_tb/master_axi_lite_vif/wdata
add wave -noupdate -expand -group AXI-Lite_WRITE_DATA /axi_microwire_tb/master_axi_lite_vif/wstrb
add wave -noupdate -expand -group AXI-Lite_WRITE_DATA /axi_microwire_tb/master_axi_lite_vif/wvalid
add wave -noupdate -expand -group AXI-Lite_WRITE_DATA /axi_microwire_tb/master_axi_lite_vif/wready
add wave -noupdate -expand -group AXI-Lite_WRITE_RESPONSE /axi_microwire_tb/master_axi_lite_vif/bresp
add wave -noupdate -expand -group AXI-Lite_WRITE_RESPONSE /axi_microwire_tb/master_axi_lite_vif/bvalid
add wave -noupdate -expand -group AXI-Lite_WRITE_RESPONSE /axi_microwire_tb/master_axi_lite_vif/bready
add wave -noupdate -expand -group AXI-MICROWIRE /axi_microwire_tb/slave_microwire_vif/microwire_data
add wave -noupdate -expand -group AXI-MICROWIRE /axi_microwire_tb/slave_microwire_vif/microwire_clk
add wave -noupdate -expand -group AXI-MICROWIRE /axi_microwire_tb/slave_microwire_vif/microwire_le
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {1904 ps}