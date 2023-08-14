
testbench: fp_adder.sv tb_fp_adder.sv
	iverilog -g2012 -o testbench fp_adder.sv tb_fp_adder.sv

test: testbench
	vvp -N testbench +vcd

show:
	gtkwave testbench.vcd testbench.gtkw >> gtkwave.log 2>&1 &


clean:
	rm -rf testbench testbench.vcd gtkwave.log