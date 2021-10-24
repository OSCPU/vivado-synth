
## Vivado Synthesis Scripts

Usage:
1. Put your RTL source files under `src/`
1. Set the correct top module name and file list in `config.tcl`
1. Change the FPGA device in `config.tcl` if necessary
1. Modify the clock port name and clock frequency in `constr/constr.xdc`
1. Run `make`
1. Get reports under `report/`
