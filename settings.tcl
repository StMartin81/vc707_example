set origin_dir "[file dirname [info script]]"

set vivado_project_name "vc707"
set bitstream_filename "${origin_dir}/${vivado_project_name}/${vivado_project_name}.runs/impl_1/design_1_wrapper.bit"
set bootloader_filename "${origin_dir}/sdk/microblaze/Release/microblaze.elf"
set memory_configuration_filename "${origin_dir}/bitstreams/${vivado_project_name}.mcs"
set memory_configuration_prm_filename "${origin_dir}/bitstreams/${vivado_project_name}.prm"
set hw_server_computer_name tuxedo-dsc
set hw_server_port 3121