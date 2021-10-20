set clk_port_name clock
set FREQ_MHz 200

set PERIOD_ns [expr 1000.0/$FREQ_MHz]
create_clock -period $PERIOD_ns -name cpu_clk [get_ports $clk_port_name]
