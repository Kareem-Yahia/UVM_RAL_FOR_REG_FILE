import reg_file_test_pkg::*;
import uvm_pkg::*;
 `include "uvm_macros.svh"

module top ();

	parameter clk_period=10;
	parameter WIDTH=8;
	parameter ADDR=4;
	parameter DEPTH=16;

	bit CLK;
	initial begin
		CLK=0;
		forever
		#(clk_period/2) CLK=~CLK;
	end

	reg_file_if #(.WIDTH(WIDTH),.ADDR(ADDR))  reg_fileif(CLK);

	RegFile #(.WIDTH(WIDTH),.ADDR(ADDR),.DEPTH(DEPTH)) reg_file(
		.CLK       (reg_fileif.CLK),
		.RST       (reg_fileif.RST),
		.WrEn      (reg_fileif.WrEn),
		.RdEn      (reg_fileif.RdEn),
		.Address   (reg_fileif.Address),
		.WrData    (reg_fileif.WrData),
		.RdData    (reg_fileif.RdData),
		.RdData_VLD(reg_fileif.RdData_VLD),
		.REG0      (reg_fileif.REG0),
		.REG1      (reg_fileif.REG1),
		.REG2      (reg_fileif.REG2),
		.REG3      (reg_fileif.REG3)
		);

	initial begin
		uvm_config_db#(virtual reg_file_if)::set(null, "uvm_test_top", "reg_fileif", reg_fileif);
		run_test("reg_file_test");	
	end


endmodule