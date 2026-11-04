IVERILOG ?= iverilog
VVP ?= vvp
YOSYS ?= yosys
.PHONY: test synth clean
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_power_island_fsm -o build/sim rtl/power_island_fsm.sv tb/tb_power_island_fsm.sv
	$(VVP) build/sim
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/power_island_fsm.sv; hierarchy -check -top power_island_fsm; synth -top power_island_fsm; stat'
clean:
	rm -f build/sim
