set topmodule ExampleTop

set src_files [list \
  "[file normalize "${src_dir}/example.v"]" \
  "[file normalize "${src_dir}/shift.v"]" \
]

# change to another device if it is unavailable by vivado
set device xczu19eg-ffvc1760-2-i
