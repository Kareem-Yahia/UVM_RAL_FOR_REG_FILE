vlib work
vlog -f sourcefile.txt +cover 
vsim -voptargs=+acc work.top -cover -classdebug -uvmcontrol=all +UVM_VERBOSITY=UVM_MEDIUM
add wave -position insertpoint  \
sim:/top/reg_fileif/CLK \
sim:/top/reg_fileif/RST \
sim:/top/reg_fileif/WrEn \
sim:/top/reg_fileif/RdEn \
sim:/top/reg_fileif/Address \
sim:/top/reg_fileif/WrData \
sim:/top/reg_fileif/RdData \
sim:/top/reg_fileif/RdData_VLD \
sim:/top/reg_fileif/REG0 \
sim:/top/reg_fileif/REG1 \
sim:/top/reg_fileif/REG2 \
sim:/top/reg_fileif/REG3

add wave -position insertpoint  \
sim:/top/reg_file/regArr

#coverage save mips1_tb.ucdb -onexit -du Pipelined_Cycle_MIPS
run 0
add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/main_env/ral_env_model/ral_model.cfg.uart_config \
sim:/uvm_root/uvm_test_top/main_env/ral_env_model/ral_model.cfg.ALU_Operand_A_config \
sim:/uvm_root/uvm_test_top/main_env/ral_env_model/ral_model.cfg.ALU_Operand_B_config \
sim:/uvm_root/uvm_test_top/main_env/ral_env_model/ral_model.cfg.Div_Ratio_config

add wave -position insertpoint  \
sim:/uvm_root/uvm_test_top/main_env/ral_env_model/adapter


run -all
#coverage report -output functional_coverage_rpt.txt -srcfile=* -detail -all -dump -annotate -directive -cvg
#coverage report -output assertion_coverage.txt -detail -assert 
#quit -sim
#vcover report mips1_tb.ucdb -details -annotate -all -output code_coverage_rpt.txt

#you can add -option to functional coverage
#you can add -classdebug in vsim command to access the classes in waveform
#you can add -uvmcontrol=all  in vsim command in case uvm
#in windows to create sourcefile.txt use dir /b > sourcefile.txt


 