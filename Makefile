VIVADO_FLAG = -nolog -nojournal -notrace

all:
	vivado $(VIVADO_FLAG) -mode batch -source synth.tcl

.PHONY: all
