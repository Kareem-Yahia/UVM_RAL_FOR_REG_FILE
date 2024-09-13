package reg_file_test_pkg;

	import reg_file_env_pkg::*;
	import reg_file_config_obj_pkg::*;
	import reg_file_sequence_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	class reg_file_test extends uvm_test;
		`uvm_component_utils(reg_file_test)

		reg_file_env main_env;
		reg_file_config_obj reg_file_config_obj_test;
		reg_file_main_sequence seq_main;
		reg_file_reset_sequence seq_reset;
		reg_file_ral_sequence seq_ral;

		function new(string name="reg_file_test" , uvm_component parent=null);
			super.new(name,parent);
		endfunction

		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			main_env=reg_file_env::type_id::create("main_env",this);
			reg_file_config_obj_test=reg_file_config_obj::type_id::create("reg_file_config_obj_test");
			seq_main=reg_file_main_sequence::type_id::create("seq_main");
			seq_reset=reg_file_reset_sequence::type_id::create("seq_reset");
			seq_ral=reg_file_ral_sequence::type_id::create("seq_ral");


			if(! uvm_config_db#(virtual reg_file_if)::get(this,"", "reg_fileif", reg_file_config_obj_test.reg_fileif_v))
				`uvm_info("build_phase","Test cann't get interface",UVM_MEDIUM)

			uvm_config_db#(reg_file_config_obj)::set(this, "*", "CFG", reg_file_config_obj_test);
			reg_file_config_obj_test.active=UVM_ACTIVE;
		endfunction

		task run_phase(uvm_phase phase);
			super.run_phase(phase);
			phase.raise_objection(this);
			
				`uvm_info("run_phase","start_reset_sequence \n",UVM_MEDIUM)
			seq_reset.start(main_env.main_agent.sequencer);

				`uvm_info("run_phase","start_main_sequence \n",UVM_MEDIUM)
			seq_main.start(main_env.main_agent.sequencer);
			
			`uvm_info("run_phase","start_ral_model_sequence \n",UVM_MEDIUM)
			seq_ral.start(main_env.main_agent.sequencer);


			`uvm_info("run_phase","END UVM ",UVM_MEDIUM)
			phase.drop_objection(this);
		endtask
	endclass
endpackage