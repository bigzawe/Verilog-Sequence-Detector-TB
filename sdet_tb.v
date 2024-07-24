`timescale	1ns/1ps

module sdet_tb();

////////////////////// DUT Signals & Parameters //////////////////////

reg		CLK_tb ;
reg		reset_tb ;
reg		i_tb ;
wire	o_tb ;

parameter	CLK_Period = 20,
			E0 = 2'b00,
			E1 = 2'b01,
			E2 = 2'b10,
			E3 = 2'b11;

////////////////////// Initial Block //////////////////////

initial
begin
	
	//// Initialization
	initialize();
	
	//// Reset
	reset();
	
	//////// Start Testing ////////
	
	//// Testing Idle
	$display("######### Test E0 (First State) #########");
	@(negedge CLK_tb)
		if(!o_tb) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	//// Testing E1
	$display("######### Test E1 (Second State) #########");
	i_tb = 'b1;
	@(negedge CLK_tb)
		if(!o_tb) $display("Functional");
		else	  $display("Error");	
	#(0.5*CLK_Period);
	
	
	//// Testing E2
	$display("######### Test E2 (Third State) #########");
	i_tb = 'b1;
	@(negedge CLK_tb)
		if(!o_tb) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	//// Testing E3
	$display("######### Test E3 (Fourth State) #########");
	i_tb = 'b1;
	@(negedge CLK_tb)
		if(o_tb) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
		
	//// Testing Reset
	$display("############# Test Reset ################");
	i_tb = 'b1;
	reset();
	@(negedge CLK_tb)
		if(!o_tb) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	i_tb = 'b0;
	
	
	#(CLK_Period)
	$stop;
end

////////////////////// Tasks //////////////////////

//// Initialize Task

task initialize;
begin
	CLK_tb   = 'b1;
	reset_tb = 'b0;
	i_tb     = 'b0;
end
endtask

//// Reset Task

task reset;
 begin
	reset_tb  = 'b1;
	#(CLK_Period)
	reset_tb  = 'b0;
 end
endtask

////////////////////// Clock Generation //////////////////////

always #(0.5*CLK_Period) CLK_tb = !CLK_tb;

////////////////////// DUT Instantiation //////////////////////

sdet DUT (
.ck(CLK_tb),
.reset(reset_tb),
.i(i_tb),
.o(o_tb)
);


endmodule