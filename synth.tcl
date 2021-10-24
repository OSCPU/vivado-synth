set script_dir  [file dirname [info script]]
set src_dir     ${script_dir}/src

source config.tcl

set rpt_dir     ${script_dir}/report
set constr_dir  ${script_dir}/constr

set xdc_files [list \
  "[file normalize "${constr_dir}/constr.xdc"]" \
]

set project_name ${topmodule}

set project_dir ${script_dir}/build/$project_name
set xpr_file $project_dir/$project_name.xpr

if {![file exists $xpr_file]} {
  create_project $project_name -force -dir $project_dir/ -part ${device}
  if {[info exists board]} {
    set_property board_part $board [current_project]
  }

  # Add files
  add_files -norecurse -fileset sources_1 $src_files
  if {[info exists xdc_files]} {
    add_files -norecurse -fileset constrs_1 $xdc_files
  }
} else {
  open_project $xpr_file
}

# setting top module for FPGA flow and simulation flow
set_property "top" $topmodule [current_fileset]

# setting Synthesis options
set_property strategy {Vivado Synthesis defaults} [get_runs synth_1]
# keep module port names in the netlist
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY {none} [get_runs synth_1]

# update compile order 
update_compile_order -fileset sources_1

set run synth_1
reset_run $run
launch_runs $run -jobs 16
wait_on_run $run

# copy reports to a new directory
set now [clock format [clock seconds] -format %Y.%m.%d-%T]
set new_rpt_dir $rpt_dir/$now-$project_name-$run
file mkdir $new_rpt_dir
file copy $project_dir/$project_name.runs/$run/$project_name.vds $new_rpt_dir/synth.log
file copy $project_dir/$project_name.runs/$run/${project_name}_utilization_synth.rpt $new_rpt_dir/utilization.rpt

open_run synth_1 -name synth_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths 10 -input_pins -routable_nets -file $new_rpt_dir/timing.rpt
