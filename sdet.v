module sdet ( ck, reset, i, o );

	input ck, reset, i ;
	output reg o ;
	parameter E0 = 2'b00;
	parameter E1 = 2'b01;
	parameter E2 = 2'b10;
	parameter E3 = 2'b11;
	reg [1:0] CS, NS;

	always @( posedge ck) begin
	CS <= NS ;
	end

	always @( CS, reset, i)begin
	if (reset)
		NS<=E0;
	else begin
		case (CS)

			E0 : if (i) NS = E1;
				else NS = E0;
			E1 : if (i) NS = E2;
				else NS = E0;
			E2 : if (i) NS <= E3;
				else NS <= E0;
			E3 : if (i) NS <= E3;
				else NS <= E0;
			default : $display ("Illegal State");
		endcase
	end
	end
	always @(CS)begin
		case (CS)

			E0 : o = 0;
			E1 : o = 0;
			E2 : o = 0;
			E3 : o = 1;
			default : $display ("Illegal State");
		endcase
	end
endmodule 